import 'dart:io';

import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final StorageService storageService;

  NotificationService({required this.storageService});

  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(Const.androidAppLogoPath);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveLocalNotification,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse);
  }

  static _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    // WIP
  }

  void _onDidReceiveLocalNotification(
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
    await initializeNotifications();
    tz.initializeTimeZones();
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(Const.notificationDurationChannelId,
            AppLocalizations.of(context)!.notificationDurationChannelName,
            importance: Importance.high,
            priority: Priority.max,
            fullScreenIntent: true,
            ticker: Const.androidTicket);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    if (durationPickerState.enabled && await _requestPermissions()) {
      int index = 0;
      for (final chabanBridgeForecast in chabanBridgeForecasts) {
        final notificationScheduleTime = chabanBridgeForecast
            .circulationClosingDate
            .subtract(durationPickerState.duration);

        /// Prevent from creating notification in the past
        if (notificationScheduleTime.isAfter(DateTime.now())) {
          await localNotifications.zonedSchedule(
              index,
              AppLocalizations.of(context)!.notificationDurationTitle,
              chabanBridgeForecast.getNotificationDurationMessage(
                  context, durationPickerState),
              tz.TZDateTime.from(
                notificationScheduleTime,
                tz.local,
              ),
              notificationDetails,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);
          index += 1;
        }
      }
    }
  }

  Future<void> showScheduledNotification() async {
    if (await _requestPermissions()) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              'next_closing_scheduled', 'Prochaine fermeture',
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await localNotifications.zonedSchedule(
          0,
          'scheduled title',
          'scheduled body',
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }
}
