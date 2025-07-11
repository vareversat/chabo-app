part of 'status_bloc.dart';

class StatusState extends Equatable {
  final StatusLifecycle statusLifecycle;
  final AbstractForecast? currentForecast;
  final AbstractForecast? previousForecast;
  final Duration durationUntilNextEvent;
  final Duration durationForCloseClosing;
  final Duration? durationBetweenPreviousAndNextEvent;
  final double completionPercentage;
  final String mainMessageStatus;
  final String timeMessagePrefix;
  final Color foregroundColor;
  final Color backgroundColor;
  final StatusWidgetDimension statusWidgetDimension;

  const StatusState({
    required this.statusLifecycle,
    required this.currentForecast,
    required this.previousForecast,
    required this.durationUntilNextEvent,
    required this.durationForCloseClosing,
    required this.durationBetweenPreviousAndNextEvent,
    required this.completionPercentage,
    required this.mainMessageStatus,
    required this.timeMessagePrefix,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.statusWidgetDimension,
  });

  StatusState copyWith({
    StatusLifecycle? statusLifecycle,
    AbstractForecast? currentForecast,
    AbstractForecast? previousForecast,
    Duration? durationUntilNextEvent,
    Duration? durationForCloseClosing,
    Duration? durationBetweenPreviousAndNextEvent,
    double? completionPercentage,
    String? mainMessageStatus,
    String? timeMessagePrefix,
    Color? foregroundColor,
    Color? backgroundColor,
    StatusWidgetDimension? statusWidgetDimension,
  }) {
    return StatusState(
      statusLifecycle: statusLifecycle ?? this.statusLifecycle,
      currentForecast: currentForecast ?? this.currentForecast,
      previousForecast: previousForecast ?? this.previousForecast,
      durationUntilNextEvent:
          durationUntilNextEvent ?? this.durationUntilNextEvent,
      durationForCloseClosing:
          durationForCloseClosing ?? this.durationForCloseClosing,
      durationBetweenPreviousAndNextEvent:
          durationBetweenPreviousAndNextEvent ??
          this.durationBetweenPreviousAndNextEvent,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      mainMessageStatus: mainMessageStatus ?? this.mainMessageStatus,
      timeMessagePrefix: timeMessagePrefix ?? this.timeMessagePrefix,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      statusWidgetDimension:
          statusWidgetDimension ?? this.statusWidgetDimension,
    );
  }

  @override
  List<Object?> get props => [
    statusLifecycle,
    currentForecast,
    previousForecast,
    durationUntilNextEvent,
    durationForCloseClosing,
    durationBetweenPreviousAndNextEvent,
    completionPercentage,
    mainMessageStatus,
    timeMessagePrefix,
    foregroundColor,
    backgroundColor,
    statusWidgetDimension,
  ];
}

class StatusStateInitial extends StatusState {
  const StatusStateInitial()
    : super(
        previousForecast: null,
        currentForecast: null,
        durationUntilNextEvent: Duration.zero,
        durationBetweenPreviousAndNextEvent: null,
        durationForCloseClosing: Const.notificationDurationValueDefaultValue,
        statusLifecycle: StatusLifecycle.loading,
        completionPercentage: 0,
        mainMessageStatus: '',
        timeMessagePrefix: '',
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        statusWidgetDimension: StatusWidgetDimension.large,
      );
}

enum StatusLifecycle { empty, populated, loading }

enum StatusWidgetDimension { small, large }
