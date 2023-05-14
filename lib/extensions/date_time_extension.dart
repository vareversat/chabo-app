import 'package:flutter/material.dart';

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
}
