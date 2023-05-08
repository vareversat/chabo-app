// ignore_for_file: use_build_context_synchronously

import 'dart:developer' as developer;
import 'dart:io';

import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/const.dart';
import 'package:chabo/extensions/date_time_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final StorageService storageService;

  static FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationService._({required this.storageService});

  static Future<NotificationService> create({
    required StorageService storageService,
  }) async {
    var notificationService =
        NotificationService._(storageService: storageService);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(Const.androidAppLogoPath);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    /// Initialize the notification plugin
    await localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveLocalNotification,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );
    developer.log(
      'Notification plugin initialized',
      name: 'notification-service.on.ctor',
    );

    /// Wip out all existing notifications
    if (!kIsWeb) {
      await localNotifications.cancelAll();
      developer.log(
        'Previous existing notifications cleaned',
        name: 'notification-service.on.ctor',
      );
    }

    return notificationService;
  }

  static _onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse,
    // ignore: avoid-unused-parameters
  ) {} // ignore: no-empty-block

  static _onDidReceiveLocalNotification(
    NotificationResponse notificationResponse,
    // ignore: avoid-unused-parameters
  ) {} // ignore: no-empty-block

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      return await androidImplementation?.requestPermission() ?? false;
    }

    return false;
  }

  Future<void> computeNotifications(
    List<AbstractChabanBridgeForecast> chabanBridgeForecasts,
    NotificationState notificationSate,
    BuildContext context,
  ) async {
    tz.initializeTimeZones();
    int index = 0;
    localNotifications.cancelAll().then((value) => null);
    List<DateTime> weekSeparatedChabanBridgeForecast = [];
    for (final chabanBridgeForecast in chabanBridgeForecasts) {
      if (notificationSate.openingNotificationEnabled) {
        index += 1;
        await _createOpeningScheduledNotifications(
          index,
          chabanBridgeForecast,
          context,
        );
      }
      if (notificationSate.closingNotificationEnabled) {
        index += 1;
        await _createClosingScheduledNotifications(
          index,
          chabanBridgeForecast,
          context,
        );
      }
      if (notificationSate.timeNotificationEnabled) {
        index += 1;
        await _createTimeScheduledNotifications(
          index,
          chabanBridgeForecast,
          context,
          notificationSate.timeNotificationValue,
        );
      }
      if (notificationSate.dayNotificationEnabled) {
        var last = chabanBridgeForecast.circulationClosingDate
            .previous(notificationSate.dayNotificationValue.weekPosition);
        if (weekSeparatedChabanBridgeForecast.isEmpty ||
            weekSeparatedChabanBridgeForecast.last == last) {
          weekSeparatedChabanBridgeForecast.add(last);
        } else {
          index += 1;
          await _createDayScheduledNotifications(
            index,
            weekSeparatedChabanBridgeForecast.length,
            weekSeparatedChabanBridgeForecast.last,
            notificationSate.dayNotificationTimeValue,
            context,
          );
          weekSeparatedChabanBridgeForecast.clear();
          weekSeparatedChabanBridgeForecast.add(last);
        }
      }
      if (notificationSate.durationNotificationEnabled) {
        index += 1;
        await _createDurationScheduledNotifications(
          index,
          chabanBridgeForecast,
          context,
          notificationSate.durationNotificationValue,
          notificationSate.durationNotificationValue.durationToString(context),
        );
      }
    }
  }

  Future<void> _createOpeningScheduledNotifications(
    int index,
    AbstractChabanBridgeForecast chabanBridgeForecast,
    BuildContext context,
  ) async {
    final notificationScheduleTime =
        chabanBridgeForecast.circulationReOpeningDate;
    NotificationDetails notificationDetails = _notificationDetails(
      Const.notificationOpeningChannelId,
      AppLocalizations.of(context)!.notificationOpeningChannelName,
    );
    await _scheduleNotification(
      index,
      AppLocalizations.of(context)!.notificationOpeningTitle,
      AppLocalizations.of(context)!.notificationOpeningMessage,
      notificationScheduleTime,
      notificationDetails,
    );
  }

  Future<void> _createClosingScheduledNotifications(
    int index,
    AbstractChabanBridgeForecast chabanBridgeForecast,
    BuildContext context,
  ) async {
    final notificationScheduleTime =
        chabanBridgeForecast.circulationClosingDate;
    NotificationDetails notificationDetails = _notificationDetails(
      Const.notificationClosingChannelId,
      AppLocalizations.of(context)!.notificationClosingChannelName,
    );
    await _scheduleNotification(
      index,
      AppLocalizations.of(context)!.notificationClosingTitle,
      chabanBridgeForecast.getNotificationClosingMessage(context),
      notificationScheduleTime,
      notificationDetails,
    );
  }

  Future<void> _createTimeScheduledNotifications(
    int index,
    AbstractChabanBridgeForecast chabanBridgeForecast,
    BuildContext context,
    TimeOfDay value,
  ) async {
    final notificationScheduleTime = chabanBridgeForecast.circulationClosingDate
        .subtract(
          const Duration(
            days: 1,
          ),
        )
        .copyWith(hour: value.hour, minute: value.minute);
    NotificationDetails notificationDetails = _notificationDetails(
      Const.notificationTimeChannelId,
      AppLocalizations.of(context)!.notificationTimeChannelName,
    );
    await _scheduleNotification(
      index,
      AppLocalizations.of(context)!.notificationTimeTitle,
      chabanBridgeForecast.getNotificationTimeMessage(context),
      notificationScheduleTime,
      notificationDetails,
    );
  }

  Future<void> _createDurationScheduledNotifications(
    int index,
    AbstractChabanBridgeForecast chabanBridgeForecast,
    BuildContext context,
    Duration durationValue,
    String durationString,
  ) async {
    final notificationScheduleTime =
        chabanBridgeForecast.circulationClosingDate.subtract(durationValue);
    NotificationDetails notificationDetails = _notificationDetails(
      Const.notificationDurationChannelId,
      AppLocalizations.of(context)!.notificationDurationChannelName,
    );
    await _scheduleNotification(
      index,
      AppLocalizations.of(context)!.notificationDurationTitle,
      chabanBridgeForecast.getNotificationDurationMessage(
        context,
        durationString,
      ),
      notificationScheduleTime,
      notificationDetails,
    );
  }

  Future<void> _createDayScheduledNotifications(
    int index,
    int closingCount,
    DateTime day,
    TimeOfDay timeOfDay,
    BuildContext context,
  ) async {
    final notificationScheduleTime =
        day.copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute, second: 0);
    NotificationDetails notificationDetails = _notificationDetails(
      Const.notificationDayChannelId,
      AppLocalizations.of(context)!.notificationDayChannelName,
    );
    await _scheduleNotification(
      index,
      AppLocalizations.of(context)!.notificationDayTitle,
      AppLocalizations.of(context)!.notificationDayMessage(closingCount),
      notificationScheduleTime,
      notificationDetails,
    );
  }

  NotificationDetails _notificationDetails(
    String notificationChannelId,
    String notificationChannelName,
  ) {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      notificationChannelId,
      notificationChannelName,
      importance: Importance.high,
      priority: Priority.max,
      ongoing: true,
      fullScreenIntent: true,
      styleInformation: const BigTextStyleInformation(''),
      ticker: Const.androidTicket,
    );

    return NotificationDetails(
      android: androidNotificationDetails,
    );
  }

  Future<void> _scheduleNotification(
    int notificationId,
    String notificationTitle,
    String notificationMessage,
    DateTime notificationScheduleTime,
    NotificationDetails notificationDetails,
  ) async {
    /// Prevent from creating notification in the past
    if (notificationScheduleTime.isAfter(DateTime.now()) &&
        await _requestPermissions()) {
      developer.log(
        'Creating a notification on channel ${notificationDetails.android!.channelId} with ID $notificationId scheduled at $notificationScheduleTime',
        name: 'notification-service.on.scheduleNotification',
      );
      await localNotifications.zonedSchedule(
        notificationId,
        notificationTitle,
        notificationMessage,
        tz.TZDateTime.from(
          notificationScheduleTime,
          tz.local,
        ),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
