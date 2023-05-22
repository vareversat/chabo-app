import 'package:chabo/models/enums/day.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime previous(int day) {
    return day == weekday
        ? subtract(Duration(
            days: 7,
            hours: hour,
            minutes: minute,
          ))
        : subtract(
            Duration(
              days: (weekday - day) % DateTime.daysPerWeek,
              hours: hour,
              minutes: minute,
            ),
          );
  }

  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  Day getDayOfTheWeek() {
    final value = EnumToString.fromString(
      Day.values,
      DateFormat('EEEE').format(this).toLowerCase(),
    );
    if (value == null) {
      throw Exception('Cannot cast $value no Day enum');
    }

    return value;
  }
}
