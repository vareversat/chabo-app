part of 'status_bloc.dart';

class StatusState extends Equatable {
  final StatusLifecycle statusLifecycle;
  final AbstractForecast? currentForecast;
  final AbstractForecast? previousForecast;
  final Duration durationUntilNextEvent;
  final Duration durationForCloseClosing;
  final bool durationForCloseClosingEnabled;
  final Duration? durationBetweenPreviousAndNextEvent;
  final double completionPercentage;
  final String mainMessageStatus;
  final String smallMessageStatus;
  final String timeMessagePrefix;
  final Color foregroundColor;
  final Color backgroundColor;
  final BridgeState bridgeState;

  const StatusState({
    required this.statusLifecycle,
    required this.currentForecast,
    required this.previousForecast,
    required this.durationUntilNextEvent,
    required this.durationForCloseClosing,
    required this.durationForCloseClosingEnabled,
    required this.durationBetweenPreviousAndNextEvent,
    required this.completionPercentage,
    required this.mainMessageStatus,
    required this.smallMessageStatus,
    required this.timeMessagePrefix,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.bridgeState,
  });

  StatusState copyWith({
    StatusLifecycle? statusLifecycle,
    AbstractForecast? currentForecast,
    AbstractForecast? previousForecast,
    Duration? durationUntilNextEvent,
    Duration? durationForCloseClosing,
    bool? durationForCloseClosingEnabled,
    Duration? durationBetweenPreviousAndNextEvent,
    double? completionPercentage,
    String? mainMessageStatus,
    String? smallMessageStatus,
    String? timeMessagePrefix,
    Color? foregroundColor,
    Color? backgroundColor,
    BridgeState? bridgeState,
  }) {
    return StatusState(
      statusLifecycle: statusLifecycle ?? this.statusLifecycle,
      currentForecast: currentForecast ?? this.currentForecast,
      previousForecast: previousForecast ?? this.previousForecast,
      durationUntilNextEvent:
          durationUntilNextEvent ?? this.durationUntilNextEvent,
      durationForCloseClosing:
          durationForCloseClosing ?? this.durationForCloseClosing,
      durationForCloseClosingEnabled:
          durationForCloseClosingEnabled ?? this.durationForCloseClosingEnabled,
      durationBetweenPreviousAndNextEvent:
          durationBetweenPreviousAndNextEvent ??
          this.durationBetweenPreviousAndNextEvent,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      mainMessageStatus: mainMessageStatus ?? this.mainMessageStatus,
      smallMessageStatus: smallMessageStatus ?? this.smallMessageStatus,
      timeMessagePrefix: timeMessagePrefix ?? this.timeMessagePrefix,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bridgeState: bridgeState ?? this.bridgeState,
    );
  }

  @override
  List<Object?> get props => [
    statusLifecycle,
    currentForecast,
    previousForecast,
    durationUntilNextEvent,
    durationForCloseClosing,
    durationForCloseClosingEnabled,
    durationBetweenPreviousAndNextEvent,
    completionPercentage,
    mainMessageStatus,
    smallMessageStatus,
    timeMessagePrefix,
    foregroundColor,
    backgroundColor,
    bridgeState,
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
        durationForCloseClosingEnabled: false,
        completionPercentage: 0,
        mainMessageStatus: '',
        smallMessageStatus: '',
        timeMessagePrefix: '',
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        bridgeState: BridgeState.open,
      );
}

enum StatusLifecycle { empty, populated, loading }

enum BridgeState { open, willSoonClose, closed }
