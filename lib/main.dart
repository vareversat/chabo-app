import 'dart:developer' as developer;

import 'package:chabo/chabo.dart';
import 'package:chabo/const.dart';
import 'package:chabo/helpers/notification_handler.dart';
import 'package:chabo/service/notification_service.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Instantiate the storage service
  final StorageService storageService = StorageService(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  /// Initialize the Google Ads plugin
  MobileAds.instance.initialize();

  /// Initialize the notification plugin
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(Const.androidAppLogoPath);
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await notificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        NotificationHandler().onDidReceiveNotificationResponse,
    onDidReceiveBackgroundNotificationResponse:
        NotificationHandler().onDidReceiveBackgroundNotificationResponse,
  );

  developer.log(
    'Notification plugin initialized',
    name: 'notification-service.on.ctor',
  );

  /// Wip out all existing notifications
  if (!kIsWeb) {
    await notificationsPlugin.cancelAll();
    developer.log(
      'Previous existing notifications cleaned',
      name: 'notification-service.on.ctor',
    );
  }

  final NotificationService notificationService = NotificationService(
    storageService: storageService,
    notificationsPlugin: notificationsPlugin,
  );

  runApp(
    Chabo(
      storageService: storageService,
      notificationService: notificationService,
    ),
  );
}
