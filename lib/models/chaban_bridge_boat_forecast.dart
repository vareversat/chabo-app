import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_reason.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_type.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ChabanBridgeBoatForecast extends AbstractChabanBridgeForecast {
  final String boatName;

  ChabanBridgeBoatForecast(
      {required bool totalClosing,
      required DateTime circulationClosingDate,
      required DateTime circulationReOpeningDate,
      required this.boatName,
      required ChabanBridgeForecastClosingType closingType})
      : super(
            circulationClosingDate: circulationClosingDate,
            circulationReOpeningDate: circulationReOpeningDate,
            closingReason: ChabanBridgeForecastClosingReason.boat,
            closingType: closingType,
            totalClosing: totalClosing,
            icon: Icons.directions_boat_sharp,
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

    return ChabanBridgeBoatForecast(
        totalClosing: totalClosing,
        boatName: json['fields']['bateau'] as String,
        circulationReOpeningDate: reopeningDate,
        circulationClosingDate: closingDate,
        closingType: closingType);
  }

  @override
  List<Object?> get props => [
        totalClosing,
        closingReason,
        duration,
        boatName,
        circulationClosingDate,
        circulationReOpeningDate,
        closingType
      ];

  void _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

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
          TextSpan(
              text:
                  '${AppLocalizations.of(context)!.dialogInformationContentBridge_closed_boat} '),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(
                  'https://www.vesselfinder.com/fr/vessels?name=$boatName&type=301'),
            text: '$boatName\n\n',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                decoration: TextDecoration.underline),
          ),
          TextSpan(
              text:
                  '${AppLocalizations.of(context)!.dialogInformationContentClosing_time.capitalize()} : '),
          TextSpan(
            text: '${durationString()}\n\n',
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
      boatName,
      durationPickerState.getDuration(),
      durationString(),
    );
  }
}
