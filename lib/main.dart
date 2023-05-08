import 'package:chabo/chabo.dart';
import 'package:chabo/service/notification_service.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final StorageService storageService = StorageService(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  final NotificationService notificationService =
      await NotificationService.create(
    storageService: storageService,
  );
  MobileAds.instance.initialize();

  runApp(
    Chabo(
      storageService: storageService,
      notificationService: notificationService,
    ),
  );
}
