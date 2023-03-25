import 'dart:convert';

import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/chaban_bridge_boat_forecast.dart';
import 'package:chabo/models/chaban_bridge_maintenance_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'chaban_bridge_forecast_event.dart';
part 'chaban_bridge_forecast_state.dart';

const _chabanBridgeForecastLimit = 1000;
const throttleDuration = Duration(milliseconds: 1000);

class ChabanBridgeForecastBloc
    extends Bloc<ChabanBridgeForecastEvent, ChabanBridgeForecastState> {
  final http.Client httpClient;

  ChabanBridgeForecastBloc({required this.httpClient})
      : super(const ChabanBridgeForecastState()) {
    on<ChabanBridgeForecastFetched>(
      _onChabanBridgeForecastFetched,
    );
  }

  Future<List<AbstractChabanBridgeForecast>> _fetchChabanBridgeForecasts(
      int offset) async {
    var uri = Uri.https(
      'opendata.bordeaux-metropole.fr',
      '/api/records/1.0/search',
      <String, String>{
        'dataset': 'previsions_pont_chaban',
        'rows': '$_chabanBridgeForecastLimit',
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

  AbstractChabanBridgeForecast _setCurrentStatus(
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
      return chabanBridgeForecast[0]
              .circulationClosingDate
              .isAfter(DateTime.now())
          ? chabanBridgeForecast[0]
          : chabanBridgeForecast[1];
    } else if (chabanBridgeForecast[middle]
        .circulationClosingDate
        .isAfter(DateTime.now())) {
      return _setCurrentStatus(chabanBridgeForecast.sublist(0, middle + 1));
    } else {
      return _setCurrentStatus(chabanBridgeForecast.sublist(middle));
    }
  }

  Future<void> _onChabanBridgeForecastFetched(ChabanBridgeForecastFetched event,
      Emitter<ChabanBridgeForecastState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ChabanBridgeForecastStatus.initial) {
        final chabanBridgeForecasts =
            await _fetchChabanBridgeForecasts(state.offset);
        emit(state.copyWith(
            status: ChabanBridgeForecastStatus.success,
            chabanBridgeForecasts: chabanBridgeForecasts,
            currentChabanBridgeForecast:
                _setCurrentStatus(chabanBridgeForecasts),
            hasReachedMax: false,
            offset: state.offset + _chabanBridgeForecastLimit));
      }
      final chabanBridgeForecasts =
          await _fetchChabanBridgeForecasts(state.chabanBridgeForecasts.length);
      emit(chabanBridgeForecasts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              currentChabanBridgeForecast: state.currentChabanBridgeForecast ??
                  _setCurrentStatus(chabanBridgeForecasts),
              status: ChabanBridgeForecastStatus.success,
              chabanBridgeForecasts: List.of(state.chabanBridgeForecasts)
                ..addAll(chabanBridgeForecasts),
              hasReachedMax: false,
              offset: state.offset + _chabanBridgeForecastLimit));
    } catch (_) {
      emit(state.copyWith(
          status: ChabanBridgeForecastStatus.failure, message: _.toString()));
    }
  }
}
