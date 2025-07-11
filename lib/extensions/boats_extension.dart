import 'package:chabo_app/extensions/string_extension.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/boat.dart';
import 'package:flutter/material.dart';

extension BoatsExtension on List<Boat> {
  TextSpan toLocalizedTextSpan(BuildContext context) {
    final finalTextSpan = <TextSpan>[];
    for (var index = 0; index < length; index++) {
      finalTextSpan.add(this[index].toLocalizedStatusTextSpan(context, true));
      if (index + 1 != length) {
        finalTextSpan.add(
          TextSpan(text: ' ${AppLocalizations.of(context)!.and} '),
        );
      }
    }

    return TextSpan(children: finalTextSpan);
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
          ? AppLocalizations.of(
              context,
            )!.notificationTimeBoatDeparture(this[index].name)
          : AppLocalizations.of(
              context,
            )!.notificationTimeBoatArrival(this[index].name);
      if (length - index > 2) {
        finalString += ', ';
      } else if (index + 1 != length) {
        finalString += ' ${AppLocalizations.of(context)!.and} ';
      }
    }

    return finalString;
  }

  List<TextSpan> toLocalizedMoonHarborStatus(BuildContext context) {
    final finalTextSpan = <TextSpan>[];
    var boatCount = 0;
    for (var index = 0; index < length; index++) {
      if (!this[index].isLeaving) {
        if (boatCount != 0) {
          finalTextSpan.add(
            TextSpan(text: ' ${AppLocalizations.of(context)!.and} '),
          );
        }
        boatCount += 1;
        finalTextSpan.add(
          TextSpan(
            text: AppLocalizations.of(
              context,
            )!.the(this[index].name.startsWithVowel().toString()).capitalize(),
          ),
        );
        finalTextSpan.add(this[index].toLocalizedTextSpan(context, true));
      }
    }

    finalTextSpan.add(
      TextSpan(
        text: ' ${AppLocalizations.of(context)!.moonHarborStatus(boatCount)}',
      ),
    );

    return finalTextSpan;
  }

  bool oneIsArriving() {
    var oneIsArriving = false;
    for (var index = 0; index < length; index++) {
      if (!this[index].isLeaving) {
        oneIsArriving = true;
      }
    }

    return oneIsArriving;
  }

  int getArrivingCount() {
    var arriving = 0;
    for (var index = 0; index < length; index++) {
      if (!this[index].isLeaving) {
        arriving += 1;
      }
    }

    return arriving;
  }

  bool isWineFestival() {
    return length == 1 && this[0].isWineFestivalSailBoats;
  }
}
