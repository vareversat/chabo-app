import 'dart:async';
import 'dart:convert';

import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/models/boat_forecast.dart';
import 'package:chabo/models/maintenance_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final http.Client httpClient;

  ForecastBloc({required this.httpClient}) : super(const ForecastState()) {
    Timer.periodic(const Duration(seconds: 1), _onRefreshCurrentStatus);
    on<ForecastFetched>(
      _onForecastFetched,
    );
  }

  void _onRefreshCurrentStatus(Timer timer) {
    try {
      if (state.status == ForecastStatus.success) {
        final currentStatus = _getCurrentStatus(state.forecasts);
        final previousStatus =
            _getPreviousStatus(state.forecasts, currentStatus);
        if (currentStatus != state.currentForecast &&
            currentStatus != previousStatus) {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(
            state.copyWith(
              currentForecast: currentStatus,
              previousForecast: previousStatus,
            ),
          );
        }
      }
    } catch (_) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(
        status: ForecastStatus.failure,
        message: _.toString(),
      ));
    }
  }

  Future<List<AbstractForecast>> _fetchForecasts(
    int offset,
  ) async {
    var uri = Uri.https(
      'opendata.bordeaux-metropole.fr',
      '/api/records/1.0/search',
      <String, String>{
        'dataset': 'previsions_pont_chaban',
        'rows': '${Const.forecastLimit}',
        'sort': '-date_passage',
        'start': '$offset',
        'timezone': 'Europe/Paris',
      },
    );
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return (body['records'] as List).map((json) {
        if (json['fields']['bateau'].toString().toLowerCase() ==
            'maintenance') {
          final maintenanceForecast = MaintenanceForecast.fromJSON(json);

          return maintenanceForecast;
        }
        final boatForecast = BoatForecast.fromJSON(json);

        return boatForecast;
      }).toList()
        ..sort((a, b) =>
            a.circulationClosingDate.compareTo(b.circulationClosingDate));
    }

    return [];
  }

  AbstractForecast _getCurrentStatus(
    List<AbstractForecast> forecast,
  ) {
    int middle = forecast.length ~/ 2;
    if ((forecast[middle].circulationClosingDate.isBefore(DateTime.now()) &&
        forecast[middle].circulationReOpeningDate.isAfter(DateTime.now()))) {
      return forecast[middle];
    }
    if (forecast.length == 2) {
      return forecast[1].circulationClosingDate.isAfter(DateTime.now()) &&
              forecast[0].circulationReOpeningDate.isBefore(DateTime.now())
          ? forecast[1]
          : forecast[0];
    } else if (forecast[middle]
        .circulationClosingDate
        .isAfter(DateTime.now())) {
      return _getCurrentStatus(forecast.sublist(0, middle + 1));
    } else {
      return _getCurrentStatus(forecast.sublist(middle));
    }
  }

  AbstractForecast? _getPreviousStatus(
    List<AbstractForecast> forecasts,
    AbstractForecast currentStatus,
  ) {
    return forecasts.indexOf(currentStatus) == 0
        ? null
        : forecasts.elementAt(forecasts.indexOf(currentStatus) - 1);
  }

  Future<void> _onForecastFetched(
    ForecastFetched event,
    Emitter<ForecastState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ForecastStatus.initial) {
        final forecasts = await _fetchForecasts(state.offset);
        final currentStatus = _getCurrentStatus(forecasts);
        emit(state.copyWith(
          status: ForecastStatus.success,
          forecasts: forecasts,
          currentForecast: currentStatus,
          previousForecast: _getPreviousStatus(forecasts, currentStatus),
          hasReachedMax: false,
          offset: state.offset + Const.forecastLimit,
        ));
      }
      final forecasts = await _fetchForecasts(state.forecasts.length);
      emit(
        forecasts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                currentForecast:
                    state.currentForecast ?? _getCurrentStatus(forecasts),
                previousForecast: state.previousForecast ??
                    _getPreviousStatus(
                      forecasts,
                      _getCurrentStatus(forecasts),
                    ),
                status: ForecastStatus.success,
                forecasts: List.of(state.forecasts)..addAll(forecasts),
                hasReachedMax: false,
                offset: state.offset + Const.forecastLimit,
              ),
      );
    } catch (_) {
      emit(state.copyWith(
        status: ForecastStatus.failure,
        message: _.toString(),
      ));
    }
  }
}
