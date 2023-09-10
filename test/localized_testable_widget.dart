import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> localizedTestableWidgetEN({required Widget child}) async {
  SharedPreferences.setMockInitialValues({});
  final StorageService storageService = StorageService(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''),
    ],
    home: BlocProvider(
      create: (BuildContext context) => TimeFormatCubit(
          storageService,
          const TimeFormatState(
            timeFormat: TimeFormat.twelveHours,
          )),
      child: child,
    ),
  );
}

Future<Widget> localizedTestableWidgetFR({required Widget child}) async {
  SharedPreferences.setMockInitialValues({});
  final StorageService storageService = StorageService(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('fr', ''),
    ],
    locale: const Locale('fr', ''),
    home: BlocProvider(
      create: (BuildContext context) => TimeFormatCubit(
          storageService,
          const TimeFormatState(
            timeFormat: TimeFormat.twentyFourHours,
          )),
      child: child,
    ),
  );
}
