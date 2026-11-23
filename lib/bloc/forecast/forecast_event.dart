part of 'forecast_bloc.dart';

abstract class ForecastEvent extends ChaboEvent {}

/// Emitted to fetch forecasts, typically on startup and while paginating.
class ForecastFetched extends ForecastEvent {}

/// Emitted by the user-facing refresh action to force a fresh network fetch.
///
/// Unlike [ForecastFetched], a refresh resets the accumulated pagination state
/// and ignores the `hasReachedMax` guard so the data is always reloaded from
/// the network (falling back to the cache when offline / the API is down).
class ForecastRefresh extends ForecastEvent {}
