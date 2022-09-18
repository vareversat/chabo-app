part of 'chaban_bridge_forecast_bloc.dart';

abstract class ChabanBridgeForecastEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChabanBridgeForecastFetched extends ChabanBridgeForecastEvent {}
