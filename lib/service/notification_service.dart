import 'dart:developer' as developer;
import 'dart:io';

import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/bloc/time_picker/time_picker_bloc.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final StorageService storageService;

  static FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationService._({required this.storageService});

  static Future<NotificationService> create(
      {required StorageService storageService}) async {
    var notificationService =
        NotificationService._(storageService: storageService);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(Const.androidAppLogoPath);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    /// Initialize the notification plugin
    await localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveLocalNotification,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse);
    developer.log('Notification plugin initialized',
        name: 'notification-service.on.ctor');

    /// Wip out all existing notifications
    if (!kIsWeb) {
      await localNotifications.cancelAll();
      developer.log('Previous existing notifications cleaned',
          name: 'notification-service.on.ctor');
    }
    return notificationService;
  }

  static _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    // WIP
  }

  static _onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) {
    // WIP
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      return await androidImplementation?.requestPermission() ?? false;
    }
    return false;
  }

  void computeDurationScheduledNotifications(
      List<AbstractChabanBridgeForecast> chabanBridgeForecasts,
      DurationPickerState durationPickerState,
      BuildContext context) async {
    tz.initializeTimeZones();
    NotificationDetails notificationDetails = _notificationDetails(
        Const.notificationDurationChannelId,
        AppLocalizations.of(context)!.notificationDurationChannelName);
    if (durationPickerState.enabled) {
      int index = Const.durationNotificationStartId;
      for (final chabanBridgeForecast in chabanBridgeForecasts) {
        final notificationScheduleTime = chabanBridgeForecast
            .circulationClosingDate
            .subtract(durationPickerState.duration);
        await _scheduleNotification(
            index,
            AppLocalizations.of(context)!.notificationDurationTitle,
            chabanBridgeForecast.getNotificationDurationMessage(
                context, durationPickerState),
            notificationScheduleTime,
            notificationDetails);
        index += 1;
      }
    }
  }

  void computeTimeScheduledNotifications(
      List<AbstractChabanBridgeForecast> chabanBridgeForecasts,
      TimePickerState timePickerState,
      BuildContext context) async {
    tz.initializeTimeZones();
    NotificationDetails notificationDetails = _notificationDetails(
        Const.notificationTimeChannelId,
        AppLocalizations.of(context)!.notificationTimeChannelName);
    if (timePickerState.enabled && await _requestPermissions()) {
      int index = Const.timeNotificationStartId;
      for (final chabanBridgeForecast in chabanBridgeForecasts) {
        final notificationScheduleTime = chabanBridgeForecast
            .circulationClosingDate
            .subtract(
              const Duration(
                days: 1,
              ),
            )
            .copyWith(
                hour: timePickerState.time.inHours,
                minute: timePickerState.time.inMinutes % 60);
        await _scheduleNotification(
            index,
            AppLocalizations.of(context)!.notificationTimeTitle,
            chabanBridgeForecast.getNotificationTimeMessage(
                context, timePickerState),
            notificationScheduleTime,
            notificationDetails);
        index += 1;
      }
    }
  }

  NotificationDetails _notificationDetails(
      String notificationChannelId, String notificationChannelName) {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            notificationChannelId, notificationChannelName,
            importance: Importance.high,
            priority: Priority.max,
            fullScreenIntent: true,
            ticker: Const.androidTicket);
    return NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> _scheduleNotification(
      int notificationId,
      String notificationTitle,
      String notificationMessage,
      DateTime notificationScheduleTime,
      NotificationDetails notificationDetails) async {
    /// Prevent from creating notification in the past
    if (notificationScheduleTime.isAfter(DateTime.now()) &&
        await _requestPermissions()) {
      developer.log(
          'Creating a notification on channel ${notificationDetails.android!.channelId} with ID $notificationId scheduled at $notificationScheduleTime',
          name: 'notification-service.on.scheduleNotification');
      return await localNotifications.zonedSchedule(
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
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }
}
