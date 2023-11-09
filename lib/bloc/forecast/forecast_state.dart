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

  const ForecastState({
    this.status = ForecastStatus.initial,
    this.forecasts = const <AbstractForecast>[],
    this.currentForecast,
    this.previousForecast,
    this.hasReachedMax = false,
    this.offset = 0,
    this.message = 'OK',
    this.noMoreForecasts = false,
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
      ];
}

enum ForecastStatus { initial, success, failure }
