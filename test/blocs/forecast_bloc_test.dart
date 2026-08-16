import 'dart:async';

import 'dart:convert';

import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/service/forecast_cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

/// A minimal in-memory fake of [ForecastCacheService] so the bloc's cache
/// layer can be exercised deterministically without touching the disk-backed
/// flutter_cache_manager (which is not available in unit tests).
class _FakeForecastCacheService implements ForecastCacheService {
  String? _body;

  @override
  Future<void> putBody({required String body, String cacheKey = ''}) async {
    _body = body;
  }

  @override
  Future<String?> getBody({String cacheKey = ''}) async => _body;

  @override
  Future<void> remove({String cacheKey = ''}) async {
    _body = null;
  }
}

/// A fake [SentryHttpClient] that returns a canned response body for every
/// request, or throws to simulate a network failure. This avoids mocking the
/// inherited [http.Client.get] concrete method.
class _FakeSentryHttpClient extends SentryHttpClient {
  _FakeSentryHttpClient({this.responseBody, this.throwOnGet = false});

  final String? responseBody;
  final bool throwOnGet;

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (throwOnGet) {
      throw Exception('SocketException: no network');
    }
    return http.Response(responseBody ?? '', 200);
  }
}

/// Builds a JSON API response body containing a single boat forecast that is
/// currently active (closing in the past, reopening in the future), so the
/// bloc's `_getCurrentStatus` returns a non-null value.
String _forecastsJson() {
  final now = DateTime.now();
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String padDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${twoDigits(d.month)}-${twoDigits(d.day)}';
  // The API uses a single `date_passage` for both the closing and re-opening
  // times, so pick today as the passage date with a closing time in the past
  // and a re-opening time in the future. This makes the forecast "currently
  // active" so the bloc's `_getCurrentStatus` returns a non-null value (and
  // avoids its recursive edge case).
  final passageDate = padDate(now);
  const closingTime = '00:01';
  const reopeningTime = '23:59';
  // record_timestamp with timezone suffix so getApiTimeZone() can parse '+02:00'.
  final recordTimestamp =
      '${padDate(now)} ${twoDigits(now.hour)}:${twoDigits(now.minute)}+02:00';
  final json = {
    'records': [
      {
        'datasetid': 'previsions_pont_chaban',
        'recordid': 'test-record-1',
        'fields': {
          'fermeture_totale': 'oui',
          'bateau': 'TEST_BOAT',
          'date_passage': passageDate,
          're_ouverture_a_la_circulation': reopeningTime,
          'fermeture_a_la_circulation': closingTime,
          'type_de_fermeture': 'Totale',
        },
        'record_timestamp': recordTimestamp,
      },
    ],
  };
  return jsonEncode(json);
}

ForecastBloc _buildBloc(
  SentryHttpClient httpClient,
  ForecastCacheService cache,
) {
  return ForecastBloc(httpClient: httpClient, cacheService: cache);
}

/// Polls the bloc's state until [test] holds true, waiting for the async
/// event handlers to emit.
Future<void> _waitFor(
  ForecastBloc bloc,
  bool Function(ForecastState state) test, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!test(bloc.state)) {
    if (DateTime.now().isAfter(deadline)) {
      throw TimeoutException('Timed out waiting for the expected state');
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

void main() {
  group('ForecastBloc caching', () {
    test(
      'network success: emits success with isFromCache=false and writes cache',
      () async {
        final body = _forecastsJson();
        final cache = _FakeForecastCacheService();
        final httpClient = _FakeSentryHttpClient(responseBody: body);

        final bloc = _buildBloc(httpClient, cache);

        bloc.add(ForecastFetched());
        await _waitFor(bloc, (s) => s.status == ForecastStatus.success);
        await bloc.close();

        expect(bloc.state.status, ForecastStatus.success);
        expect(bloc.state.isFromCache, false);
        expect(bloc.state.forecasts, isNotEmpty);
        expect(cache.getBody(), completion(isNotNull));
      },
    );

    test(
      'network failure with cache: falls back to cache and sets isFromCache',
      () async {
        final body = _forecastsJson();
        final cache = _FakeForecastCacheService();
        // Pre-populate the cache to simulate a previous successful fetch.
        await cache.putBody(body: body);
        final httpClient = _FakeSentryHttpClient(throwOnGet: true);

        final bloc = _buildBloc(httpClient, cache);

        bloc.add(ForecastFetched());
        await _waitFor(
          bloc,
          (s) => s.status == ForecastStatus.success && s.isFromCache,
        );
        await bloc.close();

        expect(bloc.state.status, ForecastStatus.success);
        expect(bloc.state.isFromCache, true);
        expect(bloc.state.forecasts, isNotEmpty);
      },
    );

    test('network failure without cache: emits failure', () async {
      final cache = _FakeForecastCacheService();
      final httpClient = _FakeSentryHttpClient(throwOnGet: true);

      final bloc = _buildBloc(httpClient, cache);

      bloc.add(ForecastFetched());
      await _waitFor(bloc, (s) => s.status == ForecastStatus.failure);
      await bloc.close();

      expect(bloc.state.status, ForecastStatus.failure);
      expect(bloc.state.forecasts, isEmpty);
    });

    test('ForecastRefresh toggles isRefreshing and reloads from network',
        () async {
      final body = _forecastsJson();
      final cache = _FakeForecastCacheService();
      final httpClient = _FakeSentryHttpClient(responseBody: body);

      final bloc = _buildBloc(httpClient, cache);

      bloc.add(ForecastFetched());
      await _waitFor(bloc, (s) => s.status == ForecastStatus.success);

      bloc.add(ForecastRefresh());
      await _waitFor(bloc, (s) => s.isRefreshing == true);
      await _waitFor(bloc, (s) => s.isRefreshing == false);
      await bloc.close();

      expect(bloc.state.status, ForecastStatus.success);
      expect(bloc.state.isFromCache, false);
      expect(bloc.state.isRefreshing, false);
    });
  });
}
