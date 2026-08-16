import 'dart:async';
import 'dart:convert';

import 'package:chabo_app/bloc/chabo_event.dart';
import 'package:chabo_app/const.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/models/boat_forecast.dart';
import 'package:chabo_app/models/maintenance_forecast.dart';
import 'package:chabo_app/service/forecast_cache_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final SentryHttpClient httpClient;
  final ForecastCacheService cacheService;

  late final Timer _currentStatusTimer;

  ForecastBloc({required this.httpClient, required this.cacheService})
    : super(const ForecastState()) {
    _currentStatusTimer = Timer.periodic(
      const Duration(seconds: 1),
      _onRefreshCurrentStatus,
    );
    on<ForecastFetched>(_onForecastFetched);
    on<ForecastRefresh>(_onForecastRefresh);
  }

  @override
  Future<void> close() {
    _currentStatusTimer.cancel();
    return super.close();
  }

  void _onRefreshCurrentStatus(Timer timer) {
    try {
      if (state.status == ForecastStatus.success) {
        final currentStatus = _getCurrentStatus(state.forecasts);
        final previousStatus = _getPreviousStatus(
          state.forecasts,
          currentStatus,
        );
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
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(status: ForecastStatus.failure, message: e.toString()),
      );
    }
  }

  /// Builds the request [Uri] for the given pagination [offset].
  Uri _buildUri(int offset) {
    return Uri.https(
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
  }

  /// Parses a raw JSON API response body into a sorted list of forecasts.
  List<AbstractForecast> _parseForecasts(String body) {
    final decoded = json.decode(body);
    return (decoded['records'] as List).map((json) {
      if (json['fields']['bateau'].toString().toLowerCase() == 'maintenance') {
        final maintenanceForecast = MaintenanceForecast.fromJSON(json);
        return maintenanceForecast;
      }
      final boatForecast = BoatForecast.fromJSON(json);
      return boatForecast;
    }).toList()..sort(
      (a, b) => a.circulationClosingDate.compareTo(b.circulationClosingDate),
    );
  }

  /// Fetches forecasts from the network for the given [offset].
  ///
  /// Returns the parsed forecasts and stores the raw response body in the
  /// cache. Throws when the network call fails or returns a non-200 status,
  /// so callers can fall back to the cache.
  Future<List<AbstractForecast>> _fetchForecastsFromNetwork(int offset) async {
    final uri = _buildUri(offset);
    final response = await httpClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception(
        'Forecast API responded with status ${response.statusCode}',
      );
    }
    // Persist the raw body so it can be served later without connectivity.
    await cacheService.putBody(body: response.body);
    return _parseForecasts(response.body);
  }

  /// Tries the network first, then falls back to the cached response.
  ///
  /// The [ForecastCacheResult] tells the caller whether the returned data came
  /// from the network or from the cache, allowing the UI to surface an
  /// "offline / cached data" indicator.
  Future<ForecastCacheResult> _fetchForecasts(int offset) async {
    try {
      final forecasts = await _fetchForecastsFromNetwork(offset);
      return ForecastCacheResult(forecasts: forecasts, fromCache: false);
    } catch (e) {
      final cachedBody = await cacheService.getBody();
      if (cachedBody != null) {
        final forecasts = _parseForecasts(cachedBody);
        return ForecastCacheResult(forecasts: forecasts, fromCache: true);
      }
      rethrow;
    }
  }

  AbstractForecast? _getCurrentStatus(List<AbstractForecast> forecast) {
    int middle = forecast.length ~/ 2;
    if ((forecast[middle].circulationClosingDate.isBefore(DateTime.now()) &&
        forecast[middle].circulationReOpeningDate.isAfter(DateTime.now()))) {
      return forecast[middle];
    }
    if (forecast.length == 2) {
      if (forecast[1].circulationClosingDate.isAfter(DateTime.now()) &&
          forecast[0].circulationReOpeningDate.isBefore(DateTime.now())) {
        return forecast[1];
      } else {
        if (!forecast[0].circulationReOpeningDate.isBefore(DateTime.now())) {
          return forecast[0];
        } else {
          return null;
        }
      }
    } else if (forecast[middle].circulationClosingDate.isAfter(
      DateTime.now(),
    )) {
      return _getCurrentStatus(forecast.sublist(0, middle + 1));
    } else {
      return _getCurrentStatus(forecast.sublist(middle));
    }
  }

  AbstractForecast? _getPreviousStatus(
    List<AbstractForecast> forecasts,
    AbstractForecast? currentStatus,
  ) {
    if (currentStatus == null) {
      return null;
    }
    return forecasts.indexOf(currentStatus) == 0
        ? null
        : forecasts.elementAt(forecasts.indexOf(currentStatus) - 1);
  }

  Future<void> _onForecastFetched(
    ForecastFetched event,
    Emitter<ForecastState> emit,
  ) async {
    if (state.hasReachedMax) return;
    await _loadForecasts(emit, reset: false);
  }

  Future<void> _onForecastRefresh(
    ForecastRefresh event,
    Emitter<ForecastState> emit,
  ) async {
    // Signal the UI that a refresh is in progress.
    emit(state.copyWith(isRefreshing: true));
    try {
      // A manual refresh always starts a fresh fetch, bypassing the pagination
      // "hasReachedMax" guard and resetting the accumulated state.
      await _loadForecasts(emit, reset: true);
    } finally {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _loadForecasts(
    Emitter<ForecastState> emit, {
    required bool reset,
  }) async {
    try {
      final baseOffset = reset ? 0 : state.offset;
      final baseForecasts = reset
          ? const <AbstractForecast>[]
          : state.forecasts;

      final result = await _fetchForecasts(baseOffset);
      final currentStatus = _getCurrentStatus(result.forecasts);
      final noMoreForecasts = currentStatus == null;

      emit(
        state.copyWith(
          status: ForecastStatus.success,
          forecasts: List.of(baseForecasts)..addAll(result.forecasts),
          currentForecast: currentStatus,
          previousForecast: _getPreviousStatus(result.forecasts, currentStatus),
          noMoreForecasts: noMoreForecasts,
          hasReachedMax: false,
          offset: baseOffset + Const.forecastLimit,
          isFromCache: result.fromCache,
          message: 'OK',
        ),
      );

      // Only attempt to load the next page when the first page came from the
      // network. When serving cached data (offline / API down) pagination is
      // not meaningful and the cache holds a single consolidated snapshot.
      if (!result.fromCache && !noMoreForecasts) {
        final nextResult = await _fetchForecasts(
          baseForecasts.length + result.forecasts.length,
        );
        if (nextResult.forecasts.isEmpty) {
          emit(state.copyWith(hasReachedMax: true, isFromCache: false));
        } else {
          emit(
            state.copyWith(
              currentForecast:
                  state.currentForecast ??
                  _getCurrentStatus(nextResult.forecasts),
              previousForecast:
                  state.previousForecast ??
                  _getPreviousStatus(
                    nextResult.forecasts,
                    _getCurrentStatus(nextResult.forecasts),
                  ),
              status: ForecastStatus.success,
              forecasts: List.of(state.forecasts)..addAll(nextResult.forecasts),
              hasReachedMax: false,
              offset: state.offset + Const.forecastLimit,
              isFromCache: nextResult.fromCache,
            ),
          );
        }
      }
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(status: ForecastStatus.failure, message: e.toString()),
      );
    }
  }
}

/// Internal helper bundling the parsed forecasts together with a flag telling
/// whether they were served from the local cache (offline / API down).
class ForecastCacheResult {
  final List<AbstractForecast> forecasts;
  final bool fromCache;

  const ForecastCacheResult({required this.forecasts, required this.fromCache});
}
