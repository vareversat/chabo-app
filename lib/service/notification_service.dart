import 'dart:io';

import 'package:chabo/const.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

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

  Future<void> showScheduledNotification() async {
    // WIP
  }

  Future<void> showNotification() async {
    if (await _requestPermissions()) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              'next_closing_scheduled', 'Prochaine fermeture',
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await localNotifications.show(
          0,
          'Pont Chaban Delmas',
          'Nouvelle fermeture du pont prévue dsqfbgkhjqsddfghsqdgfhksdlfgjhsqdfgjhsqdfg',
          notificationDetails,
          payload: 'item x');
    }
  }
}
