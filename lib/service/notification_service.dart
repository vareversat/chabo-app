import 'dart:io';

import 'package:chabo/const.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/service/storage_service.dart';
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

  void _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    //WIP
  }

  void _onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) {
    //WIP
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

  bool _areDurationNotificationsEnabled() {
    return storageService.readBool(Const.notificationDurationEnabledKey) ??
        Const.notificationDurationEnabledDefaultValue;
  }

  void computeScheduledNotifications(
      AbstractChabanBridgeForecast chabanBridgeForecast) {
    if (_areDurationNotificationsEnabled()) {}
  }

  Future<void> showScheduledNotification() async {
    if (await _requestPermissions()) {
      tz.initializeTimeZones();
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
