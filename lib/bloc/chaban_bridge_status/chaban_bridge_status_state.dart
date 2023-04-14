part of 'chaban_bridge_status_bloc.dart';

enum ChabanBridgeStatusLifespan { empty, populated }

class ChabanBridgeStatusState extends Equatable {
  final ChabanBridgeStatusLifespan chabanBridgeStatusLifespan;
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final AbstractChabanBridgeForecast? previousChabanBridgeForecast;
  final Duration durationUntilNextEvent;
  final Duration? durationBetweenPreviousAndNextEvent;
  final double completionPercentage;
  final String mainMessageStatus;
  final String timeMessagePrefix;
  final Color foregroundColor;
  final Color backgroundColor;

  const ChabanBridgeStatusState(
      {required this.chabanBridgeStatusLifespan,
      required this.currentChabanBridgeForecast,
      required this.previousChabanBridgeForecast,
      required this.durationUntilNextEvent,
      required this.durationBetweenPreviousAndNextEvent,
      required this.completionPercentage,
      required this.mainMessageStatus,
      required this.timeMessagePrefix,
      required this.foregroundColor,
      required this.backgroundColor});

  ChabanBridgeStatusState copyWith(
      {ChabanBridgeStatusLifespan? chabanBridgeStatusLifespan,
      AbstractChabanBridgeForecast? currentChabanBridgeForecast,
      AbstractChabanBridgeForecast? previousChabanBridgeForecast,
      Duration? durationUntilNextEvent,
      Duration? durationBetweenPreviousAndNextEvent,
      double? completionPercentage,
      String? mainMessageStatus,
      String? timeMessagePrefix,
      Color? foregroundColor,
      Color? backgroundColor}) {
    return ChabanBridgeStatusState(
        chabanBridgeStatusLifespan:
            chabanBridgeStatusLifespan ?? this.chabanBridgeStatusLifespan,
        currentChabanBridgeForecast:
            currentChabanBridgeForecast ?? this.currentChabanBridgeForecast,
        previousChabanBridgeForecast:
            previousChabanBridgeForecast ?? this.previousChabanBridgeForecast,
        durationUntilNextEvent:
            durationUntilNextEvent ?? this.durationUntilNextEvent,
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
        chabanBridgeStatusLifespan,
        currentChabanBridgeForecast,
        previousChabanBridgeForecast,
        durationUntilNextEvent,
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
            chabanBridgeStatusLifespan: ChabanBridgeStatusLifespan.empty,
            completionPercentage: 0,
            mainMessageStatus: '',
            timeMessagePrefix: '',
            foregroundColor: Colors.white,
            backgroundColor: Colors.white);
}
