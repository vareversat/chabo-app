import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

extension DayExtension on Day? {
  String localizedName(BuildContext context) {
    switch (this) {
      case Day.monday:
        return AppLocalizations.of(context)!.monday;
      case Day.tuesday:
        return AppLocalizations.of(context)!.tuesday;
      case Day.wednesday:
        return AppLocalizations.of(context)!.wednesday;
      case Day.thursday:
        return AppLocalizations.of(context)!.thursday;
      case Day.friday:
        return AppLocalizations.of(context)!.friday;
      case Day.saturday:
        return AppLocalizations.of(context)!.saturday;
      case Day.sunday:
        return AppLocalizations.of(context)!.sunday;
      default:
        return '';
    }
  }
}
