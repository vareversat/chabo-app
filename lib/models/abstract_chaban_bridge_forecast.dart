import 'package:chabo/models/enums/chaban_bridge_forecast_closing_reason.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

abstract class AbstractChabanBridgeForecast extends Equatable {
  final bool totalClosing;
  final ChabanBridgeForecastClosingReason closingReason;
  late final Duration duration;
  late final DateTime _circulationClosingDate;
  late final DateTime _circulationReOpeningDate;
  final ChabanBridgeForecastClosingType closingType;
  final Color color;
  final IconData icon;

  AbstractChabanBridgeForecast(
      {required this.totalClosing,
      required this.closingReason,
      required DateTime circulationClosingDate,
      required DateTime circulationReOpeningDate,
      required this.closingType,
      required this.color,
      required this.icon}) {
    _circulationClosingDate = circulationClosingDate;
    _circulationReOpeningDate = circulationReOpeningDate;

    duration = _circulationReOpeningDate.difference(_circulationClosingDate);
    if (duration.isNegative) {
      _circulationReOpeningDate =
          _circulationReOpeningDate.add(const Duration(days: 1));
      duration = _circulationReOpeningDate.difference(_circulationClosingDate);
    }
  }

  DateTime get circulationReOpeningDate => _circulationReOpeningDate.toLocal();

  Widget getInformationWidget(BuildContext context);

  set circulationReOpeningDate(DateTime value) {
    _circulationReOpeningDate = value;
  }

  DateTime get circulationClosingDate => _circulationClosingDate.toLocal();

  set circulationClosingDate(DateTime value) {
    _circulationClosingDate = value;
  }

  String circulationClosingDateString(BuildContext context) {
    return "${MaterialLocalizations.of(context).formatMediumDate(circulationClosingDate)} ${AppLocalizations.of(context)!.at} ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(circulationClosingDate)}";
  }

  String circulationReOpeningDateString(BuildContext context) {
    return "${MaterialLocalizations.of(context).formatMediumDate(circulationReOpeningDate)} ${AppLocalizations.of(context)!.at} ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(circulationReOpeningDate)}";
  }

  String durationString() {
    if (duration.inMinutes.remainder(60) == 0) {
      return "${duration.inHours}h";
    } else {
      return "${duration.inHours}h ${duration.inMinutes.remainder(60)}mins";
    }
  }

  bool isCurrentlyClosed() {
    var now = DateTime.now();
    return now.isAfter(circulationClosingDate) &&
        now.isBefore(circulationReOpeningDate);
  }

  static bool getBooleanTotalClosingValue(String stringValue) {
    if (stringValue == "oui") {
      return true;
    } else {
      return false;
    }
  }

  static String getApiTimeZone(String recordTimestamp) {
    return recordTimestamp.substring(
        recordTimestamp.indexOf('+'), recordTimestamp.length);
  }

  static DateTime parseFieldDate(
      Map<String, dynamic> json, String fieldName, String timezone) {
    return DateTime.parse(
        "${json['fields']['date_passage']}T${json['fields'][fieldName]}:00$timezone");
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
}
