import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/chaban_bridge_boat_forecast.dart';
import 'package:chabo/models/chaban_bridge_maintenance_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
    on<ChabanBridgeForecastRefreshCurrentStatus>(
      _onChabanBridgeForecastRefreshCurrentStatus,
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

  AbstractChabanBridgeForecast? _setPreviousStatus(
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
        final currentStatus = _setCurrentStatus(chabanBridgeForecasts);
        emit(state.copyWith(
            status: ChabanBridgeForecastStatus.success,
            chabanBridgeForecasts: chabanBridgeForecasts,
            currentChabanBridgeForecast: currentStatus,
            previousChabanBridgeForecast:
                _setPreviousStatus(chabanBridgeForecasts, currentStatus),
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
              previousChabanBridgeForecast:
                  state.previousChabanBridgeForecast ??
                      _setPreviousStatus(chabanBridgeForecasts,
                          _setCurrentStatus(chabanBridgeForecasts)),
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

  Future<void> _onChabanBridgeForecastRefreshCurrentStatus(
      ChabanBridgeForecastRefreshCurrentStatus event,
      Emitter<ChabanBridgeForecastState> emit) async {
    try {
      if (state.status == ChabanBridgeForecastStatus.success) {
        final currentStatus = _setCurrentStatus(state.chabanBridgeForecasts);
        emit(
          state.copyWith(
            currentChabanBridgeForecast: currentStatus,
            durationUntilNextEvent: _getDurationForNextEvent(),
            durationBetweenPreviousAndNextEvent: _getDurationBetweenPreviousAndNextEvent(),
            previousChabanBridgeForecast:
                _setPreviousStatus(state.chabanBridgeForecasts, currentStatus),
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(
          status: ChabanBridgeForecastStatus.failure, message: _.toString()));
    }
  }

  Duration? _getDurationForNextEvent() {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    final DateTime now = DateTime.now();
    if (currentChabanBridgeForecast != null) {
      if (currentChabanBridgeForecast.isCurrentlyClosed()) {
        return currentChabanBridgeForecast.circulationReOpeningDate
            .difference(now);
      } else {
        return currentChabanBridgeForecast.circulationClosingDate
            .difference(now);
      }
    } else {
      return null;
    }
  }

  Duration? _getDurationBetweenPreviousAndNextEvent() {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    final previousChabanBridgeForecast = state.previousChabanBridgeForecast;
    if (currentChabanBridgeForecast != null &&
        previousChabanBridgeForecast != null) {
      if (currentChabanBridgeForecast.isCurrentlyClosed()) {
        return currentChabanBridgeForecast.closedDuration;
      }
      else {
        return currentChabanBridgeForecast.circulationClosingDate
            .difference(previousChabanBridgeForecast.circulationReOpeningDate);
      }
    } else {
      return null;
    }
  }
}
