import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A caching layer for the Bordeaux Metropole opendata REST API responses.
///
/// It relies on [flutter_cache_manager]'s [BaseCacheManager] to persist the raw
/// JSON body of each API call on disk. This allows the app to:
///  * Serve previously fetched data when the device is offline or the API is
///    down.
///  * Refresh the data on demand by forcing a fresh network request.
class ForecastCacheService {
  static const String _defaultCacheKey = 'chabo_forecast_api';

  final BaseCacheManager _cacheManager;
  final Duration _stalePeriod;

  /// Creates a [ForecastCacheService].
  ///
  /// [cacheManager] defaults to the shared [DefaultCacheManager] instance.
  /// [stalePeriod] is the duration after which a cached entry is considered
  /// stale and eligible to be refreshed. It only controls eviction handled by
  /// the cache manager; the [ForecastBloc] always prefers fresh network data
  /// when available and falls back to the cache otherwise.
  ForecastCacheService({
    BaseCacheManager? cacheManager,
    Duration stalePeriod = const Duration(days: 30),
  }) : _cacheManager = cacheManager ?? DefaultCacheManager(),
       _stalePeriod = stalePeriod;

  /// Stores the given [body] (a JSON-encoded API response) under [cacheKey].
  Future<void> putBody({
    String body,
    String cacheKey = _defaultCacheKey,
  }) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(body));
      await _cacheManager.putFile(
        cacheKey,
        bytes,
        fileExtension: 'json',
        maxAge: _stalePeriod,
      );
    } catch (e) {
      developer.log(
        'Failed to write forecast cache: $e',
        name: 'forecast-cache-service.on.putBody',
      );
    }
  }

  /// Retrieves the cached JSON body for [cacheKey], or `null` when no entry
  /// (or an expired/invalid one) exists.
  Future<String?> getBody({String cacheKey = _defaultCacheKey}) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(cacheKey);
      if (fileInfo == null) {
        return null;
      }
      // A file present in the cache but already removed from the disk store
      // yields an invalid file; treat it as a miss.
      final file = fileInfo.file;
      if (!await file.exists()) {
        return null;
      }
      final body = await file.readAsString();
      if (body.isEmpty) {
        return null;
      }
      return body;
    } catch (e) {
      developer.log(
        'Failed to read forecast cache: $e',
        name: 'forecast-cache-service.on.getBody',
      );
      return null;
    }
  }

  /// Removes the cached entry for [cacheKey] (if any).
  Future<void> remove({String cacheKey = _defaultCacheKey}) async {
    try {
      await _cacheManager.removeFile(cacheKey);
    } catch (e) {
      developer.log(
        'Failed to remove forecast cache: $e',
        name: 'forecast-cache-service.on.remove',
      );
    }
  }
}
