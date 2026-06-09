part of 'status_bloc.dart';

class StatusEvent extends ChaboEvent {}

class StatusChanged extends StatusEvent {
  final AbstractForecast? currentForecast;
  final AbstractForecast? previousForecast;

  StatusChanged({required this.currentForecast, required this.previousForecast})
    : super();
}

class StatusRefresh extends StatusEvent {
  final BuildContext context;

  StatusRefresh({required this.context}) : super();
}

class StatusDurationChanged extends StatusEvent {
  // If the notification is enabled or not
  final bool isEnabled;

  // The duration picked
  final Duration duration;

  StatusDurationChanged({required this.duration, required this.isEnabled})
    : super();
}
