part of 'chaban_bridge_forecast_bloc.dart';

enum ChabanBridgeForecastStatus { initial, success, failure }

class ChabanBridgeForecastState extends Equatable {
  const ChabanBridgeForecastState(
      {this.status = ChabanBridgeForecastStatus.initial,
      this.chabanBridgeForecasts = const <AbstractChabanBridgeForecast>[],
      this.hasReachedMax = false,
      this.offset = 0,
      this.message = 'OK'});

  final ChabanBridgeForecastStatus status;
  final List<AbstractChabanBridgeForecast> chabanBridgeForecasts;
  final bool hasReachedMax;
  final int offset;
  final String message;

  ChabanBridgeForecastState copyWith(
      {ChabanBridgeForecastStatus? status,
      List<AbstractChabanBridgeForecast>? chabanBridgeForecasts,
      bool? hasReachedMax,
      int? offset,
      String? message}) {
    return ChabanBridgeForecastState(
        status: status ?? this.status,
        chabanBridgeForecasts:
            chabanBridgeForecasts ?? this.chabanBridgeForecasts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        offset: offset ?? this.offset,
        message: message ?? this.message);
  }

  @override
  String toString() {
    return '''ChabanBridgeForecastState { status: $status, offset: $offset, hasReachedMax: $hasReachedMax, chabanBridgeForecasts: ${chabanBridgeForecasts.length} }''';
  }

  @override
  List<Object> get props => [status, chabanBridgeForecasts, hasReachedMax];
}
