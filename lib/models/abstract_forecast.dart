import 'package:chabo/extensions/date_time_extension.dart';
import 'package:chabo/models/enums/forecast_closing_reason.dart';
import 'package:chabo/models/enums/forecast_closing_type.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AbstractForecast extends Equatable {
  final bool totalClosing;
  late final bool isDuringTwoDays;
  final ForecastClosingReason closingReason;
  late final Duration closedDuration;
  late final DateTime _circulationClosingDate;
  late final DateTime _circulationReOpeningDate;
  final ForecastClosingType closingType;
  final List<TimeSlot> interferingTimeSlots = [];

  AbstractForecast({
    required this.totalClosing,
    required this.closingReason,
    required DateTime circulationClosingDate,
    required DateTime circulationReOpeningDate,
    required this.closingType,
  }) {
    _circulationClosingDate = circulationClosingDate;

    var tmpCirculationReOpeningDate = circulationReOpeningDate.toLocal();
    var tmpDuration = tmpCirculationReOpeningDate
        .difference(_circulationClosingDate.toLocal());
    var tmpIsDuringTwoDays = false;

    if (tmpDuration.isNegative) {
      tmpIsDuringTwoDays = true;
      tmpCirculationReOpeningDate =
          tmpCirculationReOpeningDate.add(const Duration(days: 1));
      tmpDuration =
          tmpCirculationReOpeningDate.difference(_circulationClosingDate);
    }
    isDuringTwoDays = tmpIsDuringTwoDays;
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
    BuildContext context,
    String pickedDuration,
  );

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

  void computeSlotInterference(List<TimeSlot> timeSlots) {
    interferingTimeSlots.clear();
    for (var timeSlot in timeSlots) {
      if (isOverlappingWithTimeSlot(timeSlot)) {
        interferingTimeSlots.add(timeSlot);
      }
    }
  }

  bool isCurrentlyClosed() {
    return isOverlappingWith(DateTime.now());
  }

  bool hasPassed() {
    return circulationReOpeningDate.isBefore(DateTime.now());
  }

  bool isOverlappingWith(DateTime dateTime) {
    return dateTime.isAfter(circulationClosingDate) &&
        dateTime.isBefore(circulationReOpeningDate);
  }

  bool isOverlappingWithTimeSlot(TimeSlot timeSlot) {
    final startDateTime = circulationClosingDate.applied(timeSlot.from);
    final endDateTime = circulationReOpeningDate.applied(timeSlot.to);

    final startIsBeforeClosing = startDateTime.isBefore(
      circulationClosingDate,
    );

    final endIsBeforeClosing = endDateTime.isBefore(
      circulationClosingDate,
    );

    final startIsBeforeReopening = startDateTime.isBefore(
      circulationReOpeningDate,
    );
    final endIsBeforeReopening = endDateTime.isBefore(
      circulationReOpeningDate,
    );

    return (startIsBeforeClosing &&
            startIsBeforeReopening &&
            !endIsBeforeClosing &&
            endIsBeforeReopening) ||
        (!startIsBeforeClosing &&
            startIsBeforeReopening &&
            !endIsBeforeClosing &&
            !endIsBeforeReopening) ||
        (startIsBeforeClosing &&
            startIsBeforeReopening &&
            !endIsBeforeClosing &&
            !endIsBeforeReopening) ||
        (!startIsBeforeClosing &&
            startIsBeforeReopening &&
            !endIsBeforeClosing &&
            endIsBeforeReopening);
  }

  static bool getBooleanTotalClosingValue(String stringValue) {
    return stringValue == 'oui';
  }

  static String getApiTimeZone(String recordTimestamp) {
    return recordTimestamp.substring(
      recordTimestamp.indexOf('+'),
      recordTimestamp.length,
    );
  }

  static DateTime parseFieldDate(
    Map<String, dynamic> json,
    String fieldName,
    String timezone,
  ) {
    return DateTime.parse(
      "${json['fields']['date_passage']}T${json['fields'][fieldName]}:00$timezone",
    );
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
