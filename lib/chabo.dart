import 'package:chabo/app.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:chabo/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final StorageService storageService =
      StorageService(sharedPreferences: await SharedPreferences.getInstance());

  BlocOverrides.runZoned(
    () => runApp(
      Chabo(
        storageService: storageService,
      ),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}
