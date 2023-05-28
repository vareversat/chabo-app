import 'dart:developer' as developer;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse,
  ) {
    developer.log(
      'Notification open : ${notificationResponse.id} / ${notificationResponse.payload}',
      name: 'notification-service.on.didReceiveBackgroundNotificationResponse',
    );
  }

  onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
    // ignore: avoid-unused-parameters
  ) {
    developer.log(
      'Notification open : ${notificationResponse.id} / ${notificationResponse.payload}',
      name: 'notification-service.on.onDidReceiveLocalNotification',
    );
  }
}
