import 'package:chabo_app/models/enums/time_format.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

extension TilmeOfDayExtension on TimeOfDay {
  String toFormattedString(TimeFormat timeFormat) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat(timeFormat.icuName).format(dt);
  }
}
