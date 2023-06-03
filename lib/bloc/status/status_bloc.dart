import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

part 'status_event.dart';

part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(const StatusStateInitial()) {
    on<StatusChanged>(
      _onStatusChanged,
    );
    on<StatusRefresh>(
      _onRefresh,
    );
    on<StatusDurationChanged>(
      _onDurationChanged,
    );
    on<StatusWidgetDimensionChanged>(
      _onStatusWidgetDimensionChanged,
    );
  }

  void _onStatusWidgetDimensionChanged(
    StatusWidgetDimensionChanged event,
    Emitter<StatusState> emit,
  ) {
    emit(
      state.copyWith(
        statusWidgetDimension: event.dimension,
        mainMessageStatus: _getMainStatus(
          event.context,
        ),
      ),
    );
  }

  void _onDurationChanged(
    StatusDurationChanged event,
    Emitter<StatusState> emit,
  ) {
    emit(
      state.copyWith(
        durationForCloseClosing: event.duration,
      ),
    );
  }

  void _onStatusChanged(
    StatusChanged event,
    Emitter<StatusState> emit,
  ) {
    emit(
      state.copyWith(
        currentForecast: event.currentForecast,
        previousForecast: event.previousForecast,
      ),
    );
  }

  void _onRefresh(
    StatusRefresh event,
    Emitter<StatusState> emit,
  ) {
    final Duration? durationUntilNextEvent = _getDurationUntilNextEvent();
    final Duration? durationBetweenPreviousAndNextEvent =
        _getDurationBetweenPreviousAndNextEvent();
    final double completionPercentage = _getDiffPercentage(
      durationBetweenPreviousAndNextEvent,
      durationUntilNextEvent,
    );
    final String mainMessageStatus = _getMainStatus(event.context);
    final String timeMessagePrefix = _getTimeMessagePrefix(event.context);
    final Color foregroundColor = _getForegroundColor(event.context);
    final Color backgroundColor = _getBackgroundColor(event.context);

    emit(
      state.copyWith(
        durationUntilNextEvent: durationUntilNextEvent,
        durationBetweenPreviousAndNextEvent:
            durationBetweenPreviousAndNextEvent,
        completionPercentage: completionPercentage,
        mainMessageStatus: mainMessageStatus,
        timeMessagePrefix: timeMessagePrefix,
        foregroundColor: foregroundColor,
        statusLifecycle: state.durationUntilNextEvent !=
                Duration.zero // Prevents from displaying the wrong status color
            ? StatusLifecycle.populated
            : StatusLifecycle.empty,
        backgroundColor: backgroundColor,
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    final currentForecast = state.currentForecast;
    if (currentForecast != null) {
      final isOpen = !currentForecast.isCurrentlyClosed();
      if (isOpen &&
          state.durationUntilNextEvent.inMinutes <
              state.durationForCloseClosing.inMinutes) {
        return Theme.of(context).colorScheme.warningColor;
      } else if (isOpen) {
        return Theme.of(context).colorScheme.okColor;
      } else {
        return Theme.of(context).colorScheme.error;
      }
    } else {
      return state.backgroundColor;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final currentForecast = state.currentForecast;
    if (currentForecast != null) {
      final isOpen = !currentForecast.isCurrentlyClosed();
      final colorScheme = Theme.of(context).colorScheme;

      return isOpen ||
              state.durationUntilNextEvent.inMinutes <
                  state.durationForCloseClosing.inMinutes
          ? colorScheme.background
          : colorScheme.onError;
    } else {
      return state.foregroundColor;
    }
  }

  String _getTimeMessagePrefix(BuildContext context) {
    final currentForecast = state.currentForecast;
    if (currentForecast != null) {
      return currentForecast.isCurrentlyClosed()
          ? '${AppLocalizations.of(context)!.scheduledToOpen.capitalize()} '
          : '${AppLocalizations.of(context)!.nextClosingScheduled.capitalize()} ';
    } else {
      return 'NO_TIME';
    }
  }

  String _getMainStatus(BuildContext context) {
    final currentForecast = state.currentForecast;
    if (currentForecast != null &&
        !currentForecast.isCurrentlyClosed() &&
        state.durationUntilNextEvent.inMinutes >=
            state.durationForCloseClosing.inMinutes) {
      return state.statusWidgetDimension == StatusWidgetDimension.large
          ? '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.open}'
          : AppLocalizations.of(context)!.open.capitalize();
    } else if (currentForecast != null &&
        !currentForecast.isCurrentlyClosed() &&
        state.durationUntilNextEvent.inMinutes <
            state.durationForCloseClosing.inMinutes) {
      return state.statusWidgetDimension == StatusWidgetDimension.large
          ? '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.aboutToClose}'
          : AppLocalizations.of(context)!.aboutToClose.capitalize();
    } else {
      return state.statusWidgetDimension == StatusWidgetDimension.large
          ? '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.closed}'
          : AppLocalizations.of(context)!.closed.capitalize();
    }
  }

  Duration? _getDurationUntilNextEvent() {
    final currentForecast = state.currentForecast;
    final DateTime now = DateTime.now();
    if (currentForecast != null) {
      return currentForecast.isCurrentlyClosed()
          ? currentForecast.circulationReOpeningDate.difference(now)
          : currentForecast.circulationClosingDate.difference(now);
    } else {
      return null;
    }
  }

  Duration? _getDurationBetweenPreviousAndNextEvent() {
    final currentForecast = state.currentForecast;
    final previousForecast = state.previousForecast;
    if (currentForecast != null && previousForecast != null) {
      return currentForecast.isCurrentlyClosed()
          ? currentForecast.closedDuration
          : currentForecast.circulationClosingDate.difference(
              previousForecast.circulationReOpeningDate,
            );
    } else {
      return null;
    }
  }

  double _getDiffPercentage(
    Duration? durationBetweenPreviousAndNextEvent,
    Duration? durationUntilNextEvent,
  ) {
    return durationBetweenPreviousAndNextEvent != null &&
            durationUntilNextEvent != null
        ? 1 -
            (durationUntilNextEvent.inSeconds /
                durationBetweenPreviousAndNextEvent.inSeconds)
        : -1;
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
