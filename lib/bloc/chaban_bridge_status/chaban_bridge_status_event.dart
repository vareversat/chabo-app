part of 'chaban_bridge_status_bloc.dart';

class ChabanBridgeStatusEvent extends ChaboEvent {}

class ChabanBridgeStatusChanged extends ChabanBridgeStatusEvent {
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final AbstractChabanBridgeForecast? previousChabanBridgeForecast;

  ChabanBridgeStatusChanged(
      {required this.currentChabanBridgeForecast,
      required this.previousChabanBridgeForecast})
      : super();
}

class ChabanBridgeStatusRefresh extends ChabanBridgeStatusEvent {
  final BuildContext context;

  ChabanBridgeStatusRefresh({
    required this.context,
  }) : super();
}
