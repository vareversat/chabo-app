import 'dart:async';

import 'dart:convert';

import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/service/forecast_cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class _MockSentryHttpClient extends Mock implements SentryHttpClient {}

class _MockForecastCacheService extends Mock implements ForecastCacheService {}

/// Builds a JSON API response body containing a single boat forecast that is
/// currently active (closing in the past, reopening in the future), so the
/// bloc's `_getCurrentStatus` returns a non-null value.
String _forecastsJson() {
  final now = DateTime.now();
  // Use a wide window (a day each side) so the forecast stays "currently
  // active" regardless of the test machine's local timezone offset.
  final closing = now.subtract(const Duration(days: 1));
  final reopening = now.add(const Duration(days: 1));
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String padDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${twoDigits(d.month)}-${twoDigits(d.day)}';
  String padTime(DateTime d) => '${twoDigits(d.hour)}:${twoDigits(d.minute)}';
  // record_timestamp with timezone suffix so getApiTimeZone() can parse '+02:00'.
  final recordTimestamp = '${padDate(now)} ${padTime(now)}+02:00';
  final json = {
    'records': [
      {
        'datasetid': 'previsions_pont_chaban',
        'recordid': 'test-record-1',
        'fields': {
          'fermeture_totale': 'oui',
          'bateau': 'TEST_BOAT',
          'date_passage': padDate(closing),
          're_ouverture_a_la_circulation': padTime(reopening),
          'fermeture_a_la_circulation': padTime(closing),
          'type_de_fermeture': 'Totale',
        },
        'record_timestamp': recordTimestamp,
      },
    ],
  };
  return jsonEncode(json);
}

http.Response _okResponse(String body) => http.Response(body, 200);

ForecastBloc _buildBloc(
  _MockSentryHttpClient httpClient,
  _MockForecastCacheService cacheService,
) {
  return ForecastBloc(httpClient: httpClient, cacheService: cacheService);
}

/// Polls the bloc's [BlocBase.state] until [test] holds true, waiting for the
/// async event handlers to emit. Throws after [timeout] if the condition is
/// never met.
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
  late _MockSentryHttpClient httpClient;
  late _MockForecastCacheService cacheService;

  setUp(() {
    registerFallbackValue(Uri());
    httpClient = _MockSentryHttpClient();
    cacheService = _MockForecastCacheService();
    when(
      () => cacheService.putBody(body: any(named: 'body')),
    ).thenAnswer((_) async {});
    when(() => cacheService.getBody()).thenAnswer((_) async => null);
  });

  group('ForecastBloc caching', () {
    test(
      'network success: emits success with isFromCache=false and writes cache',
      () async {
        final body = _forecastsJson();
        when(
          () => httpClient.get(any()),
        ).thenAnswer((_) async => _okResponse(body));

        final bloc = _buildBloc(httpClient, cacheService);

        bloc.add(ForecastFetched());
        await _waitFor(bloc, (s) => s.status == ForecastStatus.success);
        await bloc.close();

        expect(bloc.state.status, ForecastStatus.success);
        expect(bloc.state.isFromCache, false);
        expect(bloc.state.forecasts, isNotEmpty);
        verify(
          () => cacheService.putBody(body: any(named: 'body')),
        ).called(greaterThanOrEqualTo(1));
      },
    );

    test(
      'network failure with cache: falls back to cache and sets isFromCache',
      () async {
        final cachedBody = _forecastsJson();
        when(
          () => httpClient.get(any()),
        ).thenThrow(Exception('SocketException: no network'));
        when(() => cacheService.getBody()).thenAnswer((_) async => cachedBody);

        final bloc = _buildBloc(httpClient, cacheService);

        bloc.add(ForecastFetched());
        await _waitFor(
          bloc,
          (s) => s.status == ForecastStatus.success && s.isFromCache,
        );
        await bloc.close();

        expect(bloc.state.status, ForecastStatus.success);
        expect(bloc.state.isFromCache, true);
        expect(bloc.state.forecasts, isNotEmpty);
        verifyNever(() => cacheService.putBody(body: any(named: 'body')));
      },
    );

    test('network failure without cache: emits failure', () async {
      when(
        () => httpClient.get(any()),
      ).thenThrow(Exception('SocketException: no network'));
      when(() => cacheService.getBody()).thenAnswer((_) async => null);

      final bloc = _buildBloc(httpClient, cacheService);

      bloc.add(ForecastFetched());
      await _waitFor(bloc, (s) => s.status == ForecastStatus.failure);
      await bloc.close();

      expect(bloc.state.status, ForecastStatus.failure);
      expect(bloc.state.forecasts, isEmpty);
    });

    test(
      'ForecastRefresh toggles isRefreshing and reloads from network',
      () async {
        final body = _forecastsJson();
        when(
          () => httpClient.get(any()),
        ).thenAnswer((_) async => _okResponse(body));

        final bloc = _buildBloc(httpClient, cacheService);

        bloc.add(ForecastFetched());
        await _waitFor(bloc, (s) => s.status == ForecastStatus.success);

        bloc.add(ForecastRefresh());
        await _waitFor(bloc, (s) => s.isRefreshing == true);
        await _waitFor(bloc, (s) => s.isRefreshing == false);
        await bloc.close();

        expect(bloc.state.status, ForecastStatus.success);
        expect(bloc.state.isFromCache, false);
        expect(bloc.state.isRefreshing, false);
      },
    );
  });
}
