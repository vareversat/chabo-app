import 'dart:async';
import 'dart:convert';

import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/chaban_bridge_boat_forecast.dart';
import 'package:chabo/models/chaban_bridge_maintenance_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'chaban_bridge_forecast_event.dart';
part 'chaban_bridge_forecast_state.dart';

class ChabanBridgeForecastBloc
    extends Bloc<ChabanBridgeForecastEvent, ChabanBridgeForecastState> {
  final http.Client httpClient;

  ChabanBridgeForecastBloc({required this.httpClient})
      : super(const ChabanBridgeForecastState()) {
    Timer.periodic(const Duration(seconds: 1), _onRefreshCurrentStatus);
    on<ChabanBridgeForecastFetched>(
      _onChabanBridgeForecastFetched,
    );
  }

  void _onRefreshCurrentStatus(Timer timer) {
    try {
      if (state.status == ChabanBridgeForecastStatus.success) {
        final currentStatus = _getCurrentStatus(state.chabanBridgeForecasts);
        final previousStatus =
            _getPreviousStatus(state.chabanBridgeForecasts, currentStatus);
        if (currentStatus != state.currentChabanBridgeForecast &&
            currentStatus != previousStatus) {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(
            state.copyWith(
              currentChabanBridgeForecast: currentStatus,
              previousChabanBridgeForecast: previousStatus,
            ),
          );
        }
      }
    } catch (_) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(
          status: ChabanBridgeForecastStatus.failure, message: _.toString()));
    }
  }

  Future<List<AbstractChabanBridgeForecast>> _fetchChabanBridgeForecasts(
      int offset) async {
    var uri = Uri.https(
      'opendata.bordeaux-metropole.fr',
      '/api/records/1.0/search',
      <String, String>{
        'dataset': 'previsions_pont_chaban',
        'rows': '${Const.chabanBridgeForecastLimit}',
        'sort': '-date_passage',
        'start': '$offset',
        'timezone': 'Europe/Paris'
      },
    );
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return (body['records'] as List).map((dynamic json) {
        if (json['fields']['bateau'].toString().toLowerCase() ==
            'maintenance') {
          final maintenanceForecast =
              ChabanBridgeMaintenanceForecast.fromJSON(json);
          return maintenanceForecast;
        }
        final boatForecast = ChabanBridgeBoatForecast.fromJSON(json);
        return boatForecast;
      }).toList()
        ..sort((a, b) =>
            a.circulationClosingDate.compareTo(b.circulationClosingDate));
    }
    return [];
  }

  AbstractChabanBridgeForecast _getCurrentStatus(
      List<AbstractChabanBridgeForecast> chabanBridgeForecast) {
    int middle = chabanBridgeForecast.length ~/ 2;
    if ((chabanBridgeForecast[middle]
            .circulationClosingDate
            .isBefore(DateTime.now()) &&
        chabanBridgeForecast[middle]
            .circulationReOpeningDate
            .isAfter(DateTime.now()))) {
      return chabanBridgeForecast[middle];
    }
    if (chabanBridgeForecast.length == 2) {
      return chabanBridgeForecast[1]
                  .circulationClosingDate
                  .isAfter(DateTime.now()) &&
              chabanBridgeForecast[0]
                  .circulationReOpeningDate
                  .isBefore(DateTime.now())
          ? chabanBridgeForecast[1]
          : chabanBridgeForecast[0];
    } else if (chabanBridgeForecast[middle]
        .circulationClosingDate
        .isAfter(DateTime.now())) {
      return _getCurrentStatus(chabanBridgeForecast.sublist(0, middle + 1));
    } else {
      return _getCurrentStatus(chabanBridgeForecast.sublist(middle));
    }
  }

  AbstractChabanBridgeForecast? _getPreviousStatus(
      List<AbstractChabanBridgeForecast> chabanBridgeForecasts,
      AbstractChabanBridgeForecast currentStatus) {
    if (chabanBridgeForecasts.indexOf(currentStatus) == 0) {
      return null;
    } else {
      return chabanBridgeForecasts
          .elementAt(chabanBridgeForecasts.indexOf(currentStatus) - 1);
    }
  }

  Future<void> _onChabanBridgeForecastFetched(ChabanBridgeForecastFetched event,
      Emitter<ChabanBridgeForecastState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ChabanBridgeForecastStatus.initial) {
        final chabanBridgeForecasts =
            await _fetchChabanBridgeForecasts(state.offset);
        final currentStatus = _getCurrentStatus(chabanBridgeForecasts);
        emit(state.copyWith(
            status: ChabanBridgeForecastStatus.success,
            chabanBridgeForecasts: chabanBridgeForecasts,
            currentChabanBridgeForecast: currentStatus,
            previousChabanBridgeForecast:
                _getPreviousStatus(chabanBridgeForecasts, currentStatus),
            hasReachedMax: false,
            offset: state.offset + Const.chabanBridgeForecastLimit));
      }
      final chabanBridgeForecasts =
          await _fetchChabanBridgeForecasts(state.chabanBridgeForecasts.length);
      emit(
        chabanBridgeForecasts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                currentChabanBridgeForecast:
                    state.currentChabanBridgeForecast ??
                        _getCurrentStatus(chabanBridgeForecasts),
                previousChabanBridgeForecast:
                    state.previousChabanBridgeForecast ??
                        _getPreviousStatus(chabanBridgeForecasts,
                            _getCurrentStatus(chabanBridgeForecasts)),
                status: ChabanBridgeForecastStatus.success,
                chabanBridgeForecasts: List.of(state.chabanBridgeForecasts)
                  ..addAll(chabanBridgeForecasts),
                hasReachedMax: false,
                offset: state.offset + Const.chabanBridgeForecastLimit,
              ),
      );
    } catch (_) {
      emit(state.copyWith(
          status: ChabanBridgeForecastStatus.failure, message: _.toString()));
    }
  }
}
