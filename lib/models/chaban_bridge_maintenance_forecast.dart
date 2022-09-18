import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_reason.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChabanBridgeMaintenanceForecast extends AbstractChabanBridgeForecast {
  ChabanBridgeMaintenanceForecast(
      {required bool totalClosing,
      required DateTime circulationClosingDate,
      required DateTime circulationReOpeningDate,
      required ChabanBridgeForecastClosingType closingType})
      : super(
            circulationClosingDate: circulationClosingDate,
            circulationReOpeningDate: circulationReOpeningDate,
            closingReason: ChabanBridgeForecastClosingReason.maintenance,
            closingType: closingType,
            totalClosing: totalClosing,
            icon: FontAwesomeIcons.wrench,
            color: Colors.brown);

  factory ChabanBridgeMaintenanceForecast.fromJSON(Map<String, dynamic> json) {
    var apiTimezone =
        AbstractChabanBridgeForecast.getApiTimeZone(json['record_timestamp']);
    var closingDate = AbstractChabanBridgeForecast.parseFieldDate(
        json, "fermeture_a_la_circulation", apiTimezone);
    var reopeningDate = AbstractChabanBridgeForecast.parseFieldDate(
        json, "re_ouverture_a_la_circulation", apiTimezone);
    var closingType =
        (json['fields']['type_de_fermeture'] as String).toLowerCase() ==
                "totale"
            ? ChabanBridgeForecastClosingType.complete
            : ChabanBridgeForecastClosingType.partial;
    var totalClosing = AbstractChabanBridgeForecast.getBooleanTotalClosingValue(
        json['fields']['fermeture_totale']);

    return ChabanBridgeMaintenanceForecast(
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
        circulationClosingDate,
        circulationReOpeningDate,
        closingType
      ];

  @override
  Widget getInformationWidget(BuildContext context) {
    var infoFromString =
        AppLocalizations.of(context)!.dialogInformationContentThe.capitalize();
    var infoToString =
        " ${AppLocalizations.of(context)!.dialogInformationContentFromStart} ";
    var infoToString2 =
        " ${AppLocalizations.of(context)!.dialogInformationContentFromEnd} ";
    var circulationReOpeningDateString =
        DateFormat.jm(Localizations.localeOf(context).languageCode)
            .format(circulationReOpeningDate);
    if (DateFormat("dd").format(circulationClosingDate) !=
        DateFormat("dd").format(circulationReOpeningDate)) {
      infoFromString = AppLocalizations.of(context)!
          .dialogInformationContentThe2
          .capitalize();
      infoToString =
          " ${AppLocalizations.of(context)!.dialogInformationContentFromEnd2} ";
      infoToString2 = ", ";
      circulationReOpeningDateString =
          "${MaterialLocalizations.of(context).formatFullDate(circulationReOpeningDate)}, ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(circulationReOpeningDate)}";
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
          TextSpan(text: infoToString2),
          TextSpan(
            text: DateFormat.jm(Localizations.localeOf(context).languageCode)
                .format(circulationClosingDate),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: infoToString),
          TextSpan(
            text: circulationReOpeningDateString,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                ", ${AppLocalizations.of(context)!.dialogInformationContentBridge_closed} ",
          ),
          TextSpan(
              text:
                  "${AppLocalizations.of(context)!.dialogInformationContentBridge_closed_maintenance}\n\n",
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                "${AppLocalizations.of(context)!.dialogInformationContentClosing_time.capitalize()} : ",
          ),
          TextSpan(
            text: durationString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
