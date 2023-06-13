import 'package:chabo/extensions/boats_extension.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/models/boat.dart';
import 'package:chabo/models/enums/forecast_closing_reason.dart';
import 'package:chabo/models/enums/forecast_closing_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class BoatForecast extends AbstractForecast {
  final List<Boat> boats;

  static final List<String> allBoatNames = [];

  BoatForecast({
    required bool totalClosing,
    required DateTime circulationClosingDate,
    required DateTime circulationReOpeningDate,
    required this.boats,
    required ForecastClosingType closingType,
  })  : assert(boats.isNotEmpty),
        super(
          circulationClosingDate: circulationClosingDate,
          circulationReOpeningDate: circulationReOpeningDate,
          closingReason: ForecastClosingReason.boat,
          closingType: closingType,
          totalClosing: totalClosing,
        );

  factory BoatForecast.fromJSON(Map<String, dynamic> json) {
    var apiTimezone = AbstractForecast.getApiTimeZone(json['record_timestamp']);
    var closingDate = AbstractForecast.parseFieldDate(
      json,
      'fermeture_a_la_circulation',
      apiTimezone,
    );
    var reopeningDate = AbstractForecast.parseFieldDate(
      json,
      're_ouverture_a_la_circulation',
      apiTimezone,
    );
    var closingType =
        (json['fields']['type_de_fermeture'] as String).toLowerCase() ==
                'totale'
            ? ForecastClosingType.complete
            : ForecastClosingType.partial;
    var totalClosing = AbstractForecast.getBooleanTotalClosingValue(
      json['fields']['fermeture_totale'],
    );

    List<Boat> boats = [];
    bool isLeaving = false;
    final rawBoatName = json['fields']['bateau'] as String;
    final boatNames = rawBoatName.split(RegExp(r'/'));
    for (final boatName in boatNames) {
      final trimmedBoatName = boatName.trim();
      isLeaving = allBoatNames.contains(trimmedBoatName);
      boats.add(Boat(name: trimmedBoatName, isLeaving: isLeaving));
      if (isLeaving) {
        allBoatNames.remove(trimmedBoatName);
      } else {
        allBoatNames.add(trimmedBoatName);
      }
    }

    return BoatForecast(
      boats: boats,
      totalClosing: totalClosing,
      circulationReOpeningDate: reopeningDate,
      circulationClosingDate: closingDate,
      closingType: closingType,
    );
  }

  @override
  List<Object?> get props => [
        totalClosing,
        closingReason,
        closedDuration,
        boats,
        circulationClosingDate,
        circulationReOpeningDate,
        closingType,
      ];

  @override
  RichText getInformationWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    var schedule = circulationClosingDate
        .add(Duration(microseconds: closedDuration.inMicroseconds ~/ 2));
    var scheduleString =
        DateFormat.jm(Localizations.localeOf(context).languageCode)
            .format(schedule);
    if (isDuringTwoDays) {
      scheduleString =
          '${MaterialLocalizations.of(context).formatMediumDate(schedule)} ${AppLocalizations.of(context)!.at} ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(schedule)}';
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        children: [
          ...getCoreInformationWidget(context),
          boats.toLocalizedTextSpan(context),
          TextSpan(
            text:
                '\n\n${AppLocalizations.of(context)!.dialogInformationContentTime_of_crossing.capitalize()} : ',
          ),
          TextSpan(
            text: scheduleString,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.timeColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  String getNotificationDurationMessage(
    BuildContext context,
    String pickedDuration,
  ) {
    return AppLocalizations.of(context)!.notificationDurationBoatMessage(
      boats.toLocalizedString(context),
      pickedDuration,
      closedDuration.durationToString(context),
    );
  }

  @override
  String getNotificationTimeMessage(BuildContext context) {
    return AppLocalizations.of(context)!.notificationTimeBoatMessage(
      boats.toLocalizedString(context),
      DateFormat.Hm().format(circulationClosingDate),
      closedDuration.durationToString(context),
    );
  }

  @override
  String getNotificationClosingMessage(BuildContext context) {
    return AppLocalizations.of(context)!.notificationClosingBoatMessage(
      boats.toLocalizedString(context),
      closedDuration.durationToString(context),
    );
  }

  List<Widget> _computeIconWidget(
    BuildContext context,
    IconData iconData,
    bool reversed,
    double size,
  ) {
    var icons = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          iconData,
          color: getColor(context, reversed),
          size: size,
        ),
      ),
    ];
    for (int i = 0; i < boats.length; i++) {
      icons.add(Positioned(
        right: boats[i].isLeaving ? 0 : 45,
        top: boats.length == 1 ? 4 : i * 15,
        child: RotatedBox(
          quarterTurns: boats[i].isLeaving ? 0 : 2,
          child: Icon(
            Icons.double_arrow_rounded,
            color: getColor(context, reversed),
            size: boats.length == 1 ? 19 : 15,
          ),
        ),
      ));
    }

    return icons;
  }

  @override
  Widget getIconWidget(
    BuildContext context,
    bool reversed,
    double size,
    bool isLight,
  ) {
    const iconData = Icons.directions_boat_filled_outlined;

    return isLight
        ? Icon(iconData, color: getColor(context, reversed), size: size)
        : Stack(
            children: _computeIconWidget(
              context,
              iconData,
              reversed,
              size,
            ),
          );
  }

  @override
  Color getColor(BuildContext context, bool reversed) {
    return reversed
        ? Theme.of(context).dialogBackgroundColor
        : Theme.of(context).colorScheme.boatColor;
  }

  @override
  String getClosingReason(BuildContext context) {
    return boats.getNames(context);
  }
}
