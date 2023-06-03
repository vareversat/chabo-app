import 'package:chabo/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/date_time_extension.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/models/enums/forecast_closing_reason.dart';
import 'package:chabo/models/enums/forecast_closing_type.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    _circulationClosingDate = circulationClosingDate.toLocal();

    var tmpCirculationReOpeningDate = circulationReOpeningDate.toLocal();
    var tmpDuration =
        tmpCirculationReOpeningDate.difference(_circulationClosingDate);

    if (tmpDuration.isNegative) {
      tmpCirculationReOpeningDate =
          tmpCirculationReOpeningDate.add(const Duration(days: 1));
      tmpDuration =
          tmpCirculationReOpeningDate.difference(_circulationClosingDate);
    }
    isDuringTwoDays =
        tmpCirculationReOpeningDate.day != _circulationClosingDate.day;
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

  RichText getInformationWidget(BuildContext context);

  Widget getIconWidget(BuildContext context, bool reversed, double size);

  String getNotificationDurationMessage(
    BuildContext context,
    String pickedDuration,
  );

  String getNotificationTimeMessage(BuildContext context);

  String getNotificationClosingMessage(BuildContext context);

  String getClosingReason(BuildContext context);

  Color getColor(BuildContext context, bool reversed);

  void computeSlotInterference(TimeSlotsState timeSlotsState) {
    interferingTimeSlots.clear();
    for (var timeSlot in timeSlotsState.timeSlots) {
      if (isOverlappingWithTimeSlot(timeSlot, timeSlotsState.days)) {
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

  bool _isOverlapping(DateTime dateTimeToCompare, TimeSlot timeSlot) {
    final startDateTime = dateTimeToCompare.applied(timeSlot.from);
    final endDateTime = dateTimeToCompare.applied(timeSlot.to);

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

  bool isOverlappingWithTimeSlot(TimeSlot timeSlot, List<Day> days) {
    final cDDay = circulationClosingDate.getDayOfTheWeek();
    final cODay = circulationReOpeningDate.getDayOfTheWeek();

    /// We must compute the overlapping for the open and closing date separately
    /// if open and closing dates are not during the same day
    if (cDDay != cODay) {
      /// First of all, check if the day is one of choose
      return !days.contains(cDDay) || !days.contains(cODay)
          ? false
          : _isOverlapping(circulationClosingDate, timeSlot) ||
              _isOverlapping(circulationReOpeningDate, timeSlot);
    } else {
      /// First of all, check if the day is one of choose
      return !days.contains(cDDay)
          ? false
          : _isOverlapping(circulationClosingDate, timeSlot);
    }
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

  Map<String, dynamic> toJson() {
    return {
      'total_closing': totalClosing,
      'is_during_dwo_days': isDuringTwoDays,
      'closing_reason': closingReason.name,
      'closed_duration': closedDuration.toString(),
      'closing_type': closingType.name,
      'circulation_closing_date': circulationClosingDate,
      'circulation_re_opening_date': circulationReOpeningDate,
    };
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
