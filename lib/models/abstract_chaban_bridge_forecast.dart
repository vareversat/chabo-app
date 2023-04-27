import 'package:chabo/models/enums/chaban_bridge_forecast_closing_reason.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AbstractChabanBridgeForecast extends Equatable {
  final bool totalClosing;
  final ChabanBridgeForecastClosingReason closingReason;
  late final Duration closedDuration;
  late final DateTime _circulationClosingDate;
  late final DateTime _circulationReOpeningDate;
  final ChabanBridgeForecastClosingType closingType;

  AbstractChabanBridgeForecast(
      {required this.totalClosing,
      required this.closingReason,
      required DateTime circulationClosingDate,
      required DateTime circulationReOpeningDate,
      required this.closingType}) {
    _circulationClosingDate = circulationClosingDate;

    var tmpCirculationReOpeningDate = circulationReOpeningDate;
    var tmpDuration =
        tmpCirculationReOpeningDate.difference(_circulationClosingDate);

    if (tmpDuration.isNegative) {
      tmpCirculationReOpeningDate =
          tmpCirculationReOpeningDate.add(const Duration(days: 1));
      tmpDuration =
          tmpCirculationReOpeningDate.difference(_circulationClosingDate);
    }
    _circulationReOpeningDate = tmpCirculationReOpeningDate;
    closedDuration = tmpDuration;
  }

  DateTime get circulationReOpeningDate => _circulationReOpeningDate.toLocal();

  DateTime get circulationReOpeningDateUTC => circulationClosingDate;

  set circulationReOpeningDate(DateTime value) {
    _circulationReOpeningDate = value;
  }

  DateTime get circulationClosingDate => _circulationClosingDate.toLocal();

  DateTime get circulationClosingDateUTC => _circulationClosingDate;

  set circulationClosingDate(DateTime value) {
    _circulationClosingDate = value;
  }

  Widget getInformationWidget(BuildContext context);

  Widget getIconWidget(BuildContext context, bool reversed);

  String getNotificationDurationMessage(
      BuildContext context, String pickedDuration);

  String getNotificationTimeMessage(BuildContext context);

  String getNotificationClosingMessage(BuildContext context);

  Color getColor(BuildContext context, bool reversed);

  String circulationClosingDateString(BuildContext context) {
    return DateFormat.jm(Localizations.localeOf(context).languageCode)
        .format(circulationClosingDate);
  }

  String circulationReOpeningDateString(BuildContext context) {
    return DateFormat.jm(Localizations.localeOf(context).languageCode)
        .format(circulationReOpeningDate);
  }

  bool isCurrentlyClosed() {
    var now = DateTime.now();
    return now.isAfter(circulationClosingDate) &&
        now.isBefore(circulationReOpeningDate);
  }

  static bool getBooleanTotalClosingValue(String stringValue) {
    if (stringValue == 'oui') {
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
        closedDuration,
        circulationClosingDate,
        circulationReOpeningDate,
        closingType,
      ];
}
