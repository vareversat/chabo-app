import 'package:chabo/models/boat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BoatsExtension on List<Boat> {
  TextSpan toLocalizedTextSpan(BuildContext context) {
    if (length == 1) {
      return this[0].toLocalizedString(context);
    } else {
      final finalTextSpan = <TextSpan>[];
      for (var index = 0; index < length; index++) {
        finalTextSpan.add(this[index].toLocalizedString(context));
        if (index + 1 != length) {
          finalTextSpan
              .add(TextSpan(text: ' ${AppLocalizations.of(context)!.and} '));
        }
      }

      return TextSpan(
        children: finalTextSpan,
      );
    }
  }

  String toLocalizedString(BuildContext context) {
    if (length == 1) {
      return this[0].name;
    } else {
      var finalString = '';
      for (var index = 0; index < length; index++) {
        finalString += this[index].name;
        if (index + 1 != length) {
          finalString += ' ${AppLocalizations.of(context)!.and} ';
        }
      }

      return finalString;
    }
  }
}
