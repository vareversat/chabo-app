part of 'chaban_bridge_forecast_bloc.dart';

enum ChabanBridgeForecastStatus { initial, success, failure }

class ChabanBridgeForecastState extends Equatable {
  final ChabanBridgeForecastStatus status;
  final List<AbstractChabanBridgeForecast> chabanBridgeForecasts;
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final bool hasReachedMax;
  final int offset;
  final String message;

  const ChabanBridgeForecastState(
      {this.status = ChabanBridgeForecastStatus.initial,
      this.chabanBridgeForecasts = const <AbstractChabanBridgeForecast>[],
      this.currentChabanBridgeForecast,
      this.hasReachedMax = false,
      this.offset = 0,
      this.message = 'OK'});

  ChabanBridgeForecastState copyWith(
      {ChabanBridgeForecastStatus? status,
      List<AbstractChabanBridgeForecast>? chabanBridgeForecasts,
      AbstractChabanBridgeForecast? currentChabanBridgeForecast,
      bool? hasReachedMax,
      int? offset,
      String? message}) {
    return ChabanBridgeForecastState(
        status: status ?? this.status,
        chabanBridgeForecasts:
            chabanBridgeForecasts ?? this.chabanBridgeForecasts,
        currentChabanBridgeForecast:
            currentChabanBridgeForecast ?? this.currentChabanBridgeForecast,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        offset: offset ?? this.offset,
        message: message ?? this.message);
  }

  @override
  String toString() {
    return 'ChabanBridgeForecastState{status: $status, chabanBridgeForecasts: $chabanBridgeForecasts, currentChabanBridgeForecast: $currentChabanBridgeForecast, hasReachedMax: $hasReachedMax, offset: $offset, message: $message}';
  }

  @override
  List<Object> get props =>
      [status, chabanBridgeForecasts, hasReachedMax, offset, message];
}
