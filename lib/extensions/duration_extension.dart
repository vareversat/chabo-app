import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DurationExtention on Duration {
  String durationToString(BuildContext context) {
    final dayToken = inDays == 0
        ? ''
        : '${inDays.toString()}${AppLocalizations.of(context)!.daySmall} ';
    final hourToken = inHours.remainder(24) == 0
        ? ''
        : '${inHours.remainder(24).toString()}h ';
    final minToken = inMinutes.remainder(60) == 0
        ? ''
        : '${inMinutes.remainder(60).toString()}m ';
    final secsToken = inSeconds.remainder(60) == 0
        ? ''
        : '${inSeconds.remainder(60).toString()}s ';
    return '$dayToken$hourToken$minToken$secsToken';
  }

  TimeOfDay durationToTimeOfDay() {
    return TimeOfDay(hour: inHours, minute: inMinutes % 60);
  }
}
