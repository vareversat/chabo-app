part of 'chaban_bridge_forecast_bloc.dart';

enum ChabanBridgeForecastStatus { initial, success, failure }

class ChabanBridgeForecastState extends Equatable {
  final ChabanBridgeForecastStatus status;
  final List<AbstractChabanBridgeForecast> chabanBridgeForecasts;
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final AbstractChabanBridgeForecast? previousChabanBridgeForecast;
  final Duration? durationUntilNextEvent;
  final Duration? durationBetweenPreviousAndNextEvent;
  final bool hasReachedMax;
  final int offset;
  final String message;

  const ChabanBridgeForecastState(
      {this.status = ChabanBridgeForecastStatus.initial,
      this.chabanBridgeForecasts = const <AbstractChabanBridgeForecast>[],
      this.currentChabanBridgeForecast,
      this.durationUntilNextEvent,
      this.previousChabanBridgeForecast,
      this.durationBetweenPreviousAndNextEvent,
      this.hasReachedMax = false,
      this.offset = 0,
      this.message = 'OK'});

  ChabanBridgeForecastState copyWith(
      {ChabanBridgeForecastStatus? status,
      List<AbstractChabanBridgeForecast>? chabanBridgeForecasts,
      AbstractChabanBridgeForecast? currentChabanBridgeForecast,
      AbstractChabanBridgeForecast? previousChabanBridgeForecast,
      Duration? durationUntilNextEvent,
      Duration? durationBetweenPreviousAndNextEvent,
      bool? hasReachedMax,
      int? offset,
      String? message}) {
    return ChabanBridgeForecastState(
        status: status ?? this.status,
        durationUntilNextEvent:
            durationUntilNextEvent ?? this.durationUntilNextEvent,
        durationBetweenPreviousAndNextEvent:
            durationBetweenPreviousAndNextEvent ??
                this.durationBetweenPreviousAndNextEvent,
        chabanBridgeForecasts:
            chabanBridgeForecasts ?? this.chabanBridgeForecasts,
        currentChabanBridgeForecast:
            currentChabanBridgeForecast ?? this.currentChabanBridgeForecast,
        previousChabanBridgeForecast:
            previousChabanBridgeForecast ?? this.previousChabanBridgeForecast,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        offset: offset ?? this.offset,
        message: message ?? this.message);
  }

  Color getBackgroundColor(BuildContext context) {
    final isOpen = !currentChabanBridgeForecast!.isCurrentlyClosed();
    final differenceStartingPoint = currentChabanBridgeForecast!
        .circulationReOpeningDate
        .difference(DateTime.now());
    if (isOpen && differenceStartingPoint.inMinutes <= 120) {
      return Theme.of(context).colorScheme.tertiaryContainer;
    } else if (isOpen) {
      return Colors.green;
    } else {
      return Theme.of(context).colorScheme.errorContainer;
    }
  }

  Color getForegroundColor(BuildContext context) {
    final isOpen = !currentChabanBridgeForecast!.isCurrentlyClosed();
    final differenceStartingPoint = currentChabanBridgeForecast!
        .circulationReOpeningDate
        .difference(DateTime.now());
    if (isOpen && differenceStartingPoint.inMinutes <= 120) {
      return Theme.of(context).colorScheme.onTertiaryContainer;
    } else if (isOpen) {
      return Theme.of(context).colorScheme.background;
    } else {
      return Theme.of(context).colorScheme.onErrorContainer;
    }
  }

  String nextStatusMessagePrefix(BuildContext context) {
    if (currentChabanBridgeForecast!.isCurrentlyClosed()) {
      return '${AppLocalizations.of(context)!.scheduledToOpen.capitalize()} ';
    } else {
      return '${AppLocalizations.of(context)!.nextClosingScheduled.capitalize()} ';
    }
  }

  String getCurrentStatus(BuildContext context) {
    if (currentChabanBridgeForecast!.isCurrentlyClosed()) {
      return '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.closed}';
    } else {
      return '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently}';
    }
  }

  String getCurrentStatusShort(BuildContext context) {
    if (currentChabanBridgeForecast!.isCurrentlyClosed()) {
      return AppLocalizations.of(context)!.closed;
    } else {
      return AppLocalizations.of(context)!.open;
    }
  }

  String _getGreetings(BuildContext context) {
    final now = DateTime.now();
    int hours = int.parse(DateFormat('HH').format(now));
    if (hours >= 6 && hours <= 12) {
      return AppLocalizations.of(context)!.goodMorning.capitalize();
    } else if (hours > 12 && hours <= 18) {
      return AppLocalizations.of(context)!.goodAfternoon.capitalize();
    } else {
      return AppLocalizations.of(context)!.goodEvening.capitalize();
    }
  }

  @override
  String toString() {
    return 'ChabanBridgeForecastState{status: $status, chabanBridgeForecasts: $chabanBridgeForecasts, currentChabanBridgeForecast: $currentChabanBridgeForecast, hasReachedMax: $hasReachedMax, offset: $offset, message: $message}';
  }

  @override
  List<Object> get props => [
        status,
        chabanBridgeForecasts,
        hasReachedMax,
        offset,
        message,
        currentChabanBridgeForecast ?? Object(),
        previousChabanBridgeForecast ?? Object(),
        durationUntilNextEvent ?? Object()
      ];
}
