import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/chaban_bridge_boat_forecast.dart';
import 'package:chabo/models/chaban_bridge_maintenance_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stream_transform/stream_transform.dart';

part 'chaban_bridge_forecast_event.dart';
part 'chaban_bridge_forecast_state.dart';

const _chabanBridgeForecastLimit = 10;
const throttleDuration = Duration(milliseconds: 1000);

class ChabanBridgeForecastBloc
    extends Bloc<ChabanBridgeForecastEvent, ChabanBridgeForecastState> {
  final http.Client httpClient;

  ChabanBridgeForecastBloc({required this.httpClient})
      : super(const ChabanBridgeForecastState()) {
    on<ChabanBridgeForecastFetched>(
      _onChabanBridgeForecastFetched,
      transformer: throttleDroppable(throttleDuration),
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
        'sort': "-date_passage",
        'start': '$offset',
        'timezone': 'Europe/Paris',
        'q': 'date_passage>=${DateFormat('yyyy-MM-dd').format(DateTime.now())}'
      },
    );
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return (body['records'] as List).map((dynamic json) {
        if (json['fields']['bateau'].toString().toLowerCase() ==
            "maintenance") {
          return ChabanBridgeMaintenanceForecast.fromJSON(json);
        }
        return ChabanBridgeBoatForecast.fromJSON(json);
      }).toList();
    }
    return [];
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
            hasReachedMax: false,
            offset: state.offset + _chabanBridgeForecastLimit));
      }
      final chabanBridgeForecasts =
          await _fetchChabanBridgeForecasts(state.chabanBridgeForecasts.length);
      emit(chabanBridgeForecasts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
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

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }
}
