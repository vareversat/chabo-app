import 'package:chabo_app/extensions/string_extension.dart';
import 'package:chabo_app/models/boat.dart';
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

  String getNames(BuildContext context) {
    var finalString = '';
    for (var index = 0; index < length; index++) {
      finalString += this[index].name;
      if (length - index > 2) {
        finalString += ', ';
      } else if (index + 1 != length) {
        finalString += ' ${AppLocalizations.of(context)!.and} ';
      }
    }

    return finalString;
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
}
