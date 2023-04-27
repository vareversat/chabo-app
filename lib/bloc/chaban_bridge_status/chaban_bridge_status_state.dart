part of 'chaban_bridge_status_bloc.dart';

enum ChabanBridgeStatusLifecycle { empty, populated }

class ChabanBridgeStatusState extends Equatable {
  final ChabanBridgeStatusLifecycle chabanBridgeStatusLifecycle;
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final AbstractChabanBridgeForecast? previousChabanBridgeForecast;
  final Duration durationUntilNextEvent;
  final Duration durationForCloseClosing;
  final Duration? durationBetweenPreviousAndNextEvent;
  final double completionPercentage;
  final String mainMessageStatus;
  final String timeMessagePrefix;
  final Color foregroundColor;
  final Color backgroundColor;

  const ChabanBridgeStatusState(
      {required this.chabanBridgeStatusLifecycle,
      required this.currentChabanBridgeForecast,
      required this.previousChabanBridgeForecast,
      required this.durationUntilNextEvent,
      required this.durationForCloseClosing,
      required this.durationBetweenPreviousAndNextEvent,
      required this.completionPercentage,
      required this.mainMessageStatus,
      required this.timeMessagePrefix,
      required this.foregroundColor,
      required this.backgroundColor});

  ChabanBridgeStatusState copyWith(
      {ChabanBridgeStatusLifecycle? chabanBridgeStatusLifecycle,
      AbstractChabanBridgeForecast? currentChabanBridgeForecast,
      AbstractChabanBridgeForecast? previousChabanBridgeForecast,
      Duration? durationUntilNextEvent,
      Duration? durationForCloseClosing,
      Duration? durationBetweenPreviousAndNextEvent,
      double? completionPercentage,
      String? mainMessageStatus,
      String? timeMessagePrefix,
      Color? foregroundColor,
      Color? backgroundColor}) {
    return ChabanBridgeStatusState(
        chabanBridgeStatusLifecycle:
            chabanBridgeStatusLifecycle ?? this.chabanBridgeStatusLifecycle,
        currentChabanBridgeForecast:
            currentChabanBridgeForecast ?? this.currentChabanBridgeForecast,
        previousChabanBridgeForecast:
            previousChabanBridgeForecast ?? this.previousChabanBridgeForecast,
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
        backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  @override
  List<Object?> get props => [
        chabanBridgeStatusLifecycle,
        currentChabanBridgeForecast,
        previousChabanBridgeForecast,
        durationUntilNextEvent,
        durationForCloseClosing,
        durationBetweenPreviousAndNextEvent,
        completionPercentage,
        mainMessageStatus,
        timeMessagePrefix,
        foregroundColor,
        backgroundColor
      ];
}

class ChabanBridgeStatusStateInitial extends ChabanBridgeStatusState {
  const ChabanBridgeStatusStateInitial()
      : super(
            previousChabanBridgeForecast: null,
            currentChabanBridgeForecast: null,
            durationUntilNextEvent: Duration.zero,
            durationBetweenPreviousAndNextEvent: null,
            durationForCloseClosing:
                Const.notificationDurationValueDefaultValue,
            chabanBridgeStatusLifecycle: ChabanBridgeStatusLifecycle.empty,
            completionPercentage: 0,
            mainMessageStatus: '',
            timeMessagePrefix: '',
            foregroundColor: Colors.white,
            backgroundColor: Colors.white);
}
