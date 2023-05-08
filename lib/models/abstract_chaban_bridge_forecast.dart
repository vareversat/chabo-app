import 'package:chabo/extensions/date_time_extension.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_reason.dart';
import 'package:chabo/models/enums/chaban_bridge_forecast_closing_type.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AbstractChabanBridgeForecast extends Equatable {
  final bool totalClosing;
  late bool isDuringTwoDays = false;
  final ChabanBridgeForecastClosingReason closingReason;
  late final Duration closedDuration;
  late final DateTime _circulationClosingDate;
  late final DateTime _circulationReOpeningDate;
  final ChabanBridgeForecastClosingType closingType;
  final List<TimeSlot> interferingTimeSlots = [];

  AbstractChabanBridgeForecast(
      {required this.totalClosing,
      required this.closingReason,
      required DateTime circulationClosingDate,
      required DateTime circulationReOpeningDate,
      required this.closingType}) {
    _circulationClosingDate = circulationClosingDate;

    var tmpCirculationReOpeningDate = circulationReOpeningDate.toLocal();
    var tmpDuration =
        tmpCirculationReOpeningDate.difference(_circulationClosingDate.toLocal());

    if (tmpDuration.isNegative) {
      isDuringTwoDays = true;
      tmpCirculationReOpeningDate =
          tmpCirculationReOpeningDate.add(const Duration(days: 1));
      tmpDuration =
          tmpCirculationReOpeningDate.difference(_circulationClosingDate);
    }
    _circulationReOpeningDate = tmpCirculationReOpeningDate;
    closedDuration = tmpDuration;
  }

  DateTime get circulationReOpeningDate => _circulationReOpeningDate.toLocal();

  set circulationReOpeningDate(DateTime value) {
    _circulationReOpeningDate = value;
  }

  DateTime get circulationClosingDate => _circulationClosingDate.toLocal();

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

  void checkSlotInterference(List<TimeSlot> timeSlots) {
    interferingTimeSlots.clear();
    for (var timeSlot in timeSlots) {
      if (isOverlappingWithTimeOfDay(timeSlot.to)) {
        interferingTimeSlots.add(timeSlot);
      }
    }
  }

  bool isCurrentlyClosed() {
    return isOverlappingWith(DateTime.now());
  }

  bool isOverlappingWith(DateTime dateTime) {
    return dateTime.isAfter(circulationClosingDate) &&
        dateTime.isBefore(circulationReOpeningDate);
  }

  bool isOverlappingWithTimeOfDay(TimeOfDay timeOfDay) {
    final dateTimeConversion = circulationClosingDate.applied(timeOfDay);
    return dateTimeConversion.isAfter(circulationClosingDate) &&
        dateTimeConversion.isBefore(circulationReOpeningDate);
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
