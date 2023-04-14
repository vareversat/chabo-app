import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

part 'chaban_bridge_status_event.dart';
part 'chaban_bridge_status_state.dart';

class ChabanBridgeStatusBloc
    extends Bloc<ChabanBridgeStatusEvent, ChabanBridgeStatusState> {
  ChabanBridgeStatusBloc() : super(const ChabanBridgeStatusStateInitial()) {
    on<ChabanBridgeStatusChanged>(
      _onChabanBridgeStatusChanged,
    );
    on<ChabanBridgeStatusRefresh>(
      _onRefresh,
    );
  }

  void _onChabanBridgeStatusChanged(
      ChabanBridgeStatusChanged event, Emitter<ChabanBridgeStatusState> emit) {
    emit(
      state.copyWith(
          currentChabanBridgeForecast: event.currentChabanBridgeForecast,
          previousChabanBridgeForecast: event.previousChabanBridgeForecast),
    );
  }

  void _onRefresh(
      ChabanBridgeStatusRefresh event, Emitter<ChabanBridgeStatusState> emit) {
    final Duration? durationUntilNextEvent = _getDurationUntilNextEvent();
    final Duration? durationBetweenPreviousAndNextEvent =
        _getDurationBetweenPreviousAndNextEvent();
    final double completionPercentage = _getDiffPercentage(
        durationBetweenPreviousAndNextEvent, durationUntilNextEvent);
    final String mainMessageStatus = _getMainStatus(event.context);
    final String timeMessagePrefix = _getTimeMessagePrefix(event.context);
    final Color foregroundColor = _getForegroundColor(event.context);
    final Color backgroundColor = _getBackgroundColor(event.context);

    emit(state.copyWith(
        durationUntilNextEvent: durationUntilNextEvent,
        durationBetweenPreviousAndNextEvent:
            durationBetweenPreviousAndNextEvent,
        completionPercentage: completionPercentage,
        mainMessageStatus: mainMessageStatus,
        timeMessagePrefix: timeMessagePrefix,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor));
  }

  Color _getBackgroundColor(BuildContext context) {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    if (currentChabanBridgeForecast != null) {
      final isOpen = !currentChabanBridgeForecast.isCurrentlyClosed();
      final differenceStartingPoint = currentChabanBridgeForecast
          .circulationReOpeningDate
          .difference(DateTime.now());
      if (isOpen && differenceStartingPoint.inMinutes <= 120) {
        return Theme.of(context).colorScheme.tertiaryContainer;
      } else if (isOpen) {
        return Colors.green;
      } else {
        return Theme.of(context).colorScheme.errorContainer;
      }
    } else {
      return Colors.yellow;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    if (currentChabanBridgeForecast != null) {
      final isOpen = !currentChabanBridgeForecast.isCurrentlyClosed();
      final differenceStartingPoint = currentChabanBridgeForecast
          .circulationReOpeningDate
          .difference(DateTime.now());
      if (isOpen && differenceStartingPoint.inMinutes <= 120) {
        return Theme.of(context).colorScheme.onTertiaryContainer;
      } else if (isOpen) {
        return Theme.of(context).colorScheme.background;
      } else {
        return Theme.of(context).colorScheme.onErrorContainer;
      }
    } else {
      return Colors.purple;
    }
  }

  String _getTimeMessagePrefix(BuildContext context) {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    if (currentChabanBridgeForecast != null) {
      if (currentChabanBridgeForecast.isCurrentlyClosed()) {
        return '${AppLocalizations.of(context)!.scheduledToOpen.capitalize()} ';
      } else {
        return '${AppLocalizations.of(context)!.nextClosingScheduled.capitalize()} ';
      }
    } else {
      return 'NO_TIME';
    }
  }

  String _getMainStatus(BuildContext context) {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    if (currentChabanBridgeForecast != null &&
        !currentChabanBridgeForecast.isCurrentlyClosed()) {
      return '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.open}';
    } else {
      return '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.closed}';
    }
  }

  Duration? _getDurationUntilNextEvent() {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    final DateTime now = DateTime.now();
    if (currentChabanBridgeForecast != null) {
      if (currentChabanBridgeForecast.isCurrentlyClosed()) {
        return currentChabanBridgeForecast.circulationReOpeningDate
            .difference(now);
      } else {
        return currentChabanBridgeForecast.circulationClosingDate
            .difference(now);
      }
    } else {
      return null;
    }
  }

  Duration? _getDurationBetweenPreviousAndNextEvent() {
    final currentChabanBridgeForecast = state.currentChabanBridgeForecast;
    final previousChabanBridgeForecast = state.previousChabanBridgeForecast;
    if (currentChabanBridgeForecast != null &&
        previousChabanBridgeForecast != null) {
      if (currentChabanBridgeForecast.isCurrentlyClosed()) {
        return currentChabanBridgeForecast.closedDuration;
      } else {
        return currentChabanBridgeForecast.circulationClosingDate
            .difference(previousChabanBridgeForecast.circulationReOpeningDate);
      }
    } else {
      return null;
    }
  }

  double _getDiffPercentage(Duration? durationBetweenPreviousAndNextEvent,
      Duration? durationUntilNextEvent) {
    if (durationBetweenPreviousAndNextEvent != null &&
        durationUntilNextEvent != null) {
      return 1 -
          (durationUntilNextEvent.inSeconds /
              durationBetweenPreviousAndNextEvent.inSeconds);
    } else {
      return 1;
    }
  }

  String _getGreetings(BuildContext context) {
    int hours = int.parse(DateFormat('HH').format(DateTime.now()));
    if (hours >= 6 && hours <= 12) {
      return AppLocalizations.of(context)!.goodMorning.capitalize();
    } else if (hours > 12 && hours <= 18) {
      return AppLocalizations.of(context)!.goodAfternoon.capitalize();
    } else {
      return AppLocalizations.of(context)!.goodEvening.capitalize();
    }
  }
}
