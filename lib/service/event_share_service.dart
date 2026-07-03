import 'package:chabo_app/const.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class EventShareService {
  /// Add the forecast event to the user's calendar
  static Future<bool> addToCalendar(
    BuildContext context,
    AbstractForecast forecast,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    // Create the event
    final event = Event(
      title: localizations.calendarEventTitle,
      description: forecast.getCalendarEventClosingDescription(context),
      location: localizations.calendarEventLocation,
      startDate: forecast.circulationClosingDate,
      endDate: forecast.circulationReOpeningDate,
      allDay: false,
    );

    return Add2Calendar.addEvent2Cal(event);
  }

  /// Share the forecast event via messaging apps
  static Future<void> shareEvent(
    BuildContext context,
    AbstractForecast forecast,
  ) async {
    final timeFormat = context.read<TimeFormatCubit>().state.timeFormat;
    final languageCode = Localizations.localeOf(context).languageCode;
    var stringDate = DateFormat(
      timeFormat.icuName,
      languageCode,
    ).format(forecast.circulationReOpeningDate);
    final ShareParams shareParams = ShareParams(
      title: Const.appName,
      text:
          '${AppLocalizations.of(context)!.bottomSheetAdditionalInfo_shareMessage} $stringDate',
    );

    await SharePlus.instance.share(shareParams);
  }
}
