import 'package:chabo/cubits/time_format_cubit.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/models/enums/time_format.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  TextSpan toLocalizedTextSpan(BuildContext context, Color foregroundColor) {
    final timeFormat = context.read<TimeFormatCubit>().state.timeFormat;
    final languageCode = Localizations.localeOf(context).languageCode;
    var stringDate = DateFormat(timeFormat.icuName, languageCode).format(
      this,
    );
    var timeMarker = '';

    /// Try to fetch the time marker (us based local). If it exists, indexOfTimeMarker != -1
    /// Then rewrite the date by removing the time marker
    final indexOfTimeMarker = stringDate.indexOf(' ');
    if (indexOfTimeMarker != -1) {
      timeMarker = stringDate.substring(indexOfTimeMarker, stringDate.length);
      stringDate = stringDate.substring(0, indexOfTimeMarker);
    }

    return TextSpan(
      children: [
        TextSpan(
          text: stringDate,
        ),
        TextSpan(
          text: timeMarker,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: foregroundColor),
        ),
      ],
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: foregroundColor),
    );
  }
}
