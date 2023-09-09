import 'package:chabo/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TilmeOfDayExtension on TimeOfDay {
  String toFormattedString(TimeFormat timeFormat) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat(timeFormat.icuName).format(dt);
  }
}
