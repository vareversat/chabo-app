import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/extensions/boats_extension.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/extensions/duration_extension.dart';
import 'package:chabo_app/extensions/string_extension.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/models/boat.dart';
import 'package:chabo_app/models/enums/forecast_closing_reason.dart';
import 'package:chabo_app/models/enums/forecast_closing_type.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final boatNames = rawBoatName.split(RegExp('/'));
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
    final timeFormat = context.read<TimeFormatCubit>().state.timeFormat;
    return AppLocalizations.of(context)!.notificationTimeBoatMessage(
      boats.toLocalizedString(context),
      DateFormat(timeFormat.icuName).format(circulationClosingDate),
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

  @override
  Widget getIconWidget(
    BuildContext context,
    bool reversed,
    double size,
    bool isLight,
  ) {
    if (isLight) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          Icons.directions_boat_rounded,
          color: getColor(context, reversed),
          size: size,
        ),
      );
    } else {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.directions_boat_rounded,
              color: getColor(context, reversed),
              size: size,
            ),
          ),
          Positioned(
            right: 0,
            top: -3,
            child: RotatedBox(
              quarterTurns: boats[0].isLeaving ? 0 : 2,
              child: Icon(
                Icons.double_arrow_rounded,
                color: getColor(context, reversed),
                size: 15,
              ),
            ),
          ),
          boats.length == 2
              ? Positioned(
                  right: 0,
                  top: 10,
                  child: RotatedBox(
                    quarterTurns: boats[1].isLeaving ? 0 : 2,
                    child: Icon(
                      Icons.double_arrow_rounded,
                      color: getColor(context, reversed),
                      size: 15,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );
    }
  }

  @override
  Color getColor(BuildContext context, bool reversed) {
    if (boats.isWineFestival()) {
      return reversed
          ? Theme.of(context).dialogBackgroundColor
          : Theme.of(context).colorScheme.bordeauxColor;
    }

    return reversed
        ? Theme.of(context).dialogBackgroundColor
        : Theme.of(context).colorScheme.boatColor;
  }

  @override
  String getClosingReason(BuildContext context) {
    return boats.getNames(context);
  }
}
