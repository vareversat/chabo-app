part of 'forecast_bloc.dart';

class ForecastState extends Equatable {
  final ForecastStatus status;
  final List<AbstractForecast> forecasts;
  final AbstractForecast? currentForecast;
  final AbstractForecast? previousForecast;
  final bool noMoreForecasts;
  final bool hasReachedMax;
  final int offset;
  final String message;

  /// `true` when the currently displayed data comes from the local cache
  /// (e.g. the device is offline or the opendata API is down). `false` when
  /// the data was freshly fetched from the network.
  final bool isFromCache;

  /// `true` while a manual [ForecastRefresh] is in progress, so the UI can
  /// display a loading indicator on the refresh button.
  final bool isRefreshing;

  const ForecastState({
    this.status = ForecastStatus.initial,
    this.forecasts = const <AbstractForecast>[],
    this.currentForecast,
    this.previousForecast,
    this.hasReachedMax = false,
    this.offset = 0,
    this.message = 'OK',
    this.noMoreForecasts = false,
    this.isFromCache = false,
    this.isRefreshing = false,
  });

  ForecastState copyWith({
    ForecastStatus? status,
    List<AbstractForecast>? forecasts,
    AbstractForecast? currentForecast,
    AbstractForecast? previousForecast,
    bool? noMoreForecasts,
    bool? hasReachedMax,
    int? offset,
    String? message,
    bool? isFromCache,
    bool? isRefreshing,
  }) {
    return ForecastState(
      status: status ?? this.status,
      forecasts: forecasts ?? this.forecasts,
      currentForecast: currentForecast ?? this.currentForecast,
      previousForecast: previousForecast ?? this.previousForecast,
      noMoreForecasts: noMoreForecasts ?? this.noMoreForecasts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
      message: message ?? this.message,
      isFromCache: isFromCache ?? this.isFromCache,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    forecasts,
    hasReachedMax,
    offset,
    message,
    currentForecast,
    previousForecast,
    isFromCache,
    isRefreshing,
  ];
}

enum ForecastStatus { initial, success, failure }
