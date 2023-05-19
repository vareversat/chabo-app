part of 'status_bloc.dart';

class StatusEvent extends ChaboEvent {}

class StatusChanged extends StatusEvent {
  final AbstractForecast? currentForecast;
  final AbstractForecast? previousForecast;

  StatusChanged({
    required this.currentForecast,
    required this.previousForecast,
  }) : super();
}

class StatusRefresh extends StatusEvent {
  final BuildContext context;

  StatusRefresh({
    required this.context,
  }) : super();
}

class StatusDurationChanged extends StatusEvent {
  final Duration duration;

  StatusDurationChanged({
    required this.duration,
  }) : super();
}

class StatusWidgetDimensionChanged extends StatusEvent {
  final StatusWidgetDimension dimension;
  final BuildContext context;

  StatusWidgetDimensionChanged({
    required this.dimension,
    required this.context,
  }) : super();
}
