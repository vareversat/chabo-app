import 'package:chabo/chabo.dart';
import 'package:chabo/service/notification_service.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:chabo/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  BlocOverrides.runZoned(
    () => runApp(
      Chabo(
          storageService: storageService,
          notificationService: notificationService),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}
