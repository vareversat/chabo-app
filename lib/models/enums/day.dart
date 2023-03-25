import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension DayExtension on Day? {
  int get weekPosition {
    switch (this) {
      case Day.monday:
        return 1;
      case Day.tuesday:
        return 2;
      case Day.wednesday:
        return 3;
      case Day.thursday:
        return 4;
      case Day.friday:
        return 5;
      case Day.saturday:
        return 6;
      case Day.sunday:
        return 7;
      default:
        return -1;
    }
  }

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
        return 'no_date';
    }
  }
}
