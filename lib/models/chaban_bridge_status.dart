import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ChabanBridgeStatus {
  final AbstractChabanBridgeForecast nextChabanBridgeForecast;
  final DateTime now = DateTime.now();
  late String currentStatus;
  late String currentStatusShort;
  late String nextStatusMessagePrefix;
  late Duration differenceStartingPoint;
  late String remainingTime;
  late bool isOpen;

  ChabanBridgeStatus(
      {required this.nextChabanBridgeForecast, required BuildContext context}) {
    if (nextChabanBridgeForecast.isCurrentlyClosed()) {
      differenceStartingPoint =
          nextChabanBridgeForecast.circulationReOpeningDate.difference(now);
      nextStatusMessagePrefix =
          AppLocalizations.of(context)!.scheduledToOpen.capitalize();
      currentStatusShort = AppLocalizations.of(context)!.closed;
      currentStatus =
          '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently} ${AppLocalizations.of(context)!.closed}';
    } else {
      differenceStartingPoint =
          nextChabanBridgeForecast.circulationClosingDate.difference(now);
      nextStatusMessagePrefix =
          AppLocalizations.of(context)!.nextClosingScheduled.capitalize();
      currentStatusShort = AppLocalizations.of(context)!.open;
    }
    nextStatusMessagePrefix += ' : ';
    remainingTime = _formatRemainingTime(
        differenceStartingPoint.inDays,
        differenceStartingPoint.inHours.remainder(24),
        differenceStartingPoint.inMinutes.remainder(60),
        context);
    currentStatus =
        '${_getGreetings(context)}, ${AppLocalizations.of(context)!.theBridgeIsCurrently}';
    isOpen = !nextChabanBridgeForecast.isCurrentlyClosed();
  }

  String _formatRemainingTime(
      int days, int hours, int mins, BuildContext context) {
    String minSuffix = mins > 1 ? 'mins' : 'min';
    if (days == 0) {
      return '${hours}h $mins$minSuffix';
    } else if (hours == 0) {
      return '$days${AppLocalizations.of(context)!.daySmall} $mins$minSuffix';
    } else if (mins == 0) {
      return '$days${AppLocalizations.of(context)!.daySmall} ${hours}h';
    } else {
      return '$days${AppLocalizations.of(context)!.daySmall} ${hours}h $mins$minSuffix';
    }
  }

  Color getBackgroundColor(BuildContext context) {
    if (isOpen && differenceStartingPoint.inMinutes <= 120) {
      return Theme.of(context).colorScheme.tertiaryContainer;
    } else if (isOpen) {
      return Theme.of(context).colorScheme.primaryContainer;
    } else {
      return Theme.of(context).colorScheme.errorContainer;
    }
  }

  Color getForegroundColor(BuildContext context) {
    if (isOpen && differenceStartingPoint.inMinutes <= 120) {
      return Theme.of(context).colorScheme.onTertiaryContainer;
    } else if (isOpen) {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    } else {
      return Theme.of(context).colorScheme.onErrorContainer;
    }
  }

  String _getGreetings(BuildContext context) {
    int hours = int.parse(DateFormat('HH').format(now));
    if (hours >= 6 && hours <= 12) {
      return AppLocalizations.of(context)!.goodMorning.capitalize();
    } else if (hours > 12 && hours <= 18) {
      return AppLocalizations.of(context)!.goodAfternoon.capitalize();
    } else {
      return AppLocalizations.of(context)!.goodEvening.capitalize();
    }
  }
}
