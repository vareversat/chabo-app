import 'package:chabo/models/boat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BoatsExtension on List<Boat> {
  TextSpan toLocalizedTextSpan(BuildContext context) {
    final finalTextSpan = <TextSpan>[];
    for (var index = 0; index < length; index++) {
      finalTextSpan.add(
        this[index].toLocalizedStatusTextSpan(
          context,
          true,
        ),
      );
      if (index + 1 != length) {
        finalTextSpan
            .add(TextSpan(text: ' ${AppLocalizations.of(context)!.and} '));
      }
    }

    return TextSpan(
      children: finalTextSpan,
    );
  }

  String toLocalizedString(BuildContext context) {
    var finalString = '';
    for (var index = 0; index < length; index++) {
      finalString += this[index].isLeaving
          ? AppLocalizations.of(context)!
              .notificationTimeBoatDeparture(this[index].name)
          : AppLocalizations.of(context)!
              .notificationTimeBoatArrival(this[index].name);
      if (index + 1 != length) {
        finalString += ' ${AppLocalizations.of(context)!.and} ';
      }
    }

    return finalString;
  }

  String toLocalizedMoonHarborStatus(BuildContext context) {
    var finalString = '';
    var boatCount = 0;
    for (var index = 0; index < length; index++) {
      if (!this[index].isLeaving) {
        boatCount += 1;
        finalString += this[index].name;
      }
      if (index + 1 != length) {
        finalString += ' ${AppLocalizations.of(context)!.and} ';
      }
    }

    /// If no boats previously entered into the Moon Harbor, return nothing
    return boatCount == 0
        ? ''
        : AppLocalizations.of(context)!
            .moonHarborStatus(finalString, boatCount);
  }
}
