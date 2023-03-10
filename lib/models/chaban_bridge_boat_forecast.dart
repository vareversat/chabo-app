import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/bloc/time_picker/time_picker_bloc.dart';
import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/boat.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_reason.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ChabanBridgeBoatForecast extends AbstractChabanBridgeForecast {
  final List<Boat> boats;

  static final List<String> allBoatNames = [];

  ChabanBridgeBoatForecast(
      {required bool totalClosing,
      required DateTime circulationClosingDate,
      required DateTime circulationReOpeningDate,
      required this.boats,
      required ChabanBridgeForecastClosingType closingType})
      : assert(boats.isNotEmpty),
        super(
            circulationClosingDate: circulationClosingDate,
            circulationReOpeningDate: circulationReOpeningDate,
            closingReason: ChabanBridgeForecastClosingReason.boat,
            closingType: closingType,
            totalClosing: totalClosing,
            color: Colors.blue);

  factory ChabanBridgeBoatForecast.fromJSON(Map<String, dynamic> json) {
    var apiTimezone =
        AbstractChabanBridgeForecast.getApiTimeZone(json['record_timestamp']);
    var closingDate = AbstractChabanBridgeForecast.parseFieldDate(
        json, 'fermeture_a_la_circulation', apiTimezone);
    var reopeningDate = AbstractChabanBridgeForecast.parseFieldDate(
        json, 're_ouverture_a_la_circulation', apiTimezone);
    var closingType =
        (json['fields']['type_de_fermeture'] as String).toLowerCase() ==
                'totale'
            ? ChabanBridgeForecastClosingType.complete
            : ChabanBridgeForecastClosingType.partial;
    var totalClosing = AbstractChabanBridgeForecast.getBooleanTotalClosingValue(
        json['fields']['fermeture_totale']);

    List<Boat> boats = [];
    bool isLeaving = false;
    final rawBoatName = json['fields']['bateau'] as String;
    final boatNames = rawBoatName.split(' / ');
    for (final boatName in boatNames) {
      isLeaving = allBoatNames.contains(boatName);
      boats.add(Boat(name: boatName, isLeaving: isLeaving));
      if (isLeaving) {
        allBoatNames.remove(boatName);
      } else {
        allBoatNames.add(boatName);
      }
    }

    return ChabanBridgeBoatForecast(
        boats: boats,
        totalClosing: totalClosing,
        circulationReOpeningDate: reopeningDate,
        circulationClosingDate: closingDate,
        closingType: closingType);
  }

  @override
  List<Object?> get props => [
        totalClosing,
        closingReason,
        duration,
        boats,
        circulationClosingDate,
        circulationReOpeningDate,
        closingType
      ];

  @override
  Widget getInformationWidget(BuildContext context) {
    var schedule = circulationClosingDate
        .add(Duration(microseconds: duration.inMicroseconds ~/ 2));
    var scheduleString =
        DateFormat.jm(Localizations.localeOf(context).languageCode)
            .format(schedule);
    var infoFromString =
        AppLocalizations.of(context)!.dialogInformationContentThe.capitalize();
    var infoToString =
        ' ${AppLocalizations.of(context)!.dialogInformationContentFromStart} ';
    var infoToString2 =
        ' ${AppLocalizations.of(context)!.dialogInformationContentFromEnd} ';
    var circulationReOpeningDateString =
        DateFormat.jm(Localizations.localeOf(context).languageCode)
            .format(circulationReOpeningDate);
    if (DateFormat('dd').format(circulationClosingDate) !=
        DateFormat('dd').format(circulationReOpeningDate)) {
      scheduleString =
          '${MaterialLocalizations.of(context).formatMediumDate(schedule)} ${AppLocalizations.of(context)!.at} ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(schedule)}';
      infoFromString = AppLocalizations.of(context)!
          .dialogInformationContentThe2
          .capitalize();
      infoToString =
          ' ${AppLocalizations.of(context)!.dialogInformationContentFromEnd2} ';
      infoToString2 = ', ';
      circulationReOpeningDateString =
          '${MaterialLocalizations.of(context).formatFullDate(circulationReOpeningDate)}, ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(circulationReOpeningDate)}';
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: infoFromString),
          TextSpan(
            text: MaterialLocalizations.of(context)
                .formatFullDate(circulationClosingDate),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: infoToString),
          TextSpan(
            text: DateFormat.jm(Localizations.localeOf(context).languageCode)
                .format(circulationClosingDate),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: infoToString2),
          TextSpan(
            text: circulationReOpeningDateString,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text:
                  ', ${AppLocalizations.of(context)!.dialogInformationContentBridge_closed} '),
          boats.toLocalizedTextSpan(context),
          TextSpan(
              text:
                  '\n\n${AppLocalizations.of(context)!.dialogInformationContentClosing_time.capitalize()} : '),
          TextSpan(
            text: '${durationString()}\n',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          TextSpan(
              text:
                  '${AppLocalizations.of(context)!.dialogInformationContentTime_of_crossing.capitalize()} : '),
          TextSpan(
            text: scheduleString,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  @override
  String getNotificationDurationMessage(
      BuildContext context, DurationPickerState durationPickerState) {
    return AppLocalizations.of(context)!.notificationDurationBoatMessage(
      boats.toLocalizedString(context),
      durationPickerState.getDuration(),
      durationString(),
    );
  }

  @override
  String getNotificationTimeMessage(
      BuildContext context, TimePickerState timePickerState) {
    return AppLocalizations.of(context)!.notificationTimeBoatMessage(
      boats.toLocalizedString(context),
      DateFormat.Hm().format(circulationClosingDate),
      durationString(),
    );
  }

  @override
  Widget getIconWidget(Color? color) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            Icons.directions_boat_rounded,
            color: color ?? this.color,
            size: 30,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: RotatedBox(
            quarterTurns: boats[0].isLeaving ? 0 : 2,
            child: Icon(
              Icons.double_arrow_rounded,
              color: color ?? this.color,
              size: 18,
            ),
          ),
        ),
        boats.length == 2
            ? Positioned(
                right: 0,
                top: 14,
                child: RotatedBox(
                  quarterTurns: boats[1].isLeaving ? 0 : 2,
                  child: Icon(
                    Icons.double_arrow_rounded,
                    color: color ?? this.color,
                    size: 18,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
