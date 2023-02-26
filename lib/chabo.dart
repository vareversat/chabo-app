import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/day_picker/day_picker_bloc.dart';
import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/bloc/theme/theme_bloc.dart';
import 'package:chabo/bloc/time_picker/time_picker_bloc.dart';
import 'package:chabo/screens/chaban_bridge_forecast_screen.dart';
import 'package:chabo/service/notification_service.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

class Chabo extends StatelessWidget {
  final StorageService storageService;

  const Chabo({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Bloc intended to manage the theme of the App
        BlocProvider(
          create: (_) => ThemeBloc(storageService: storageService)
            ..add(
              AppStateChanged(),
            ),
        ),

        /// Bloc intended to manage the duration type Notification
        BlocProvider(
          create: (_) => DurationPickerBloc(storageService: storageService)
            ..add(
              DurationAppStateChanged(),
            ),
        ),

        /// Bloc intended to manage the time type Notification
        BlocProvider(
          create: (_) => TimePickerBloc(storageService: storageService)
            ..add(
              TimeAppStateChanged(),
            ),
        ),

        /// Bloc intended to manage the day type Notification
        BlocProvider(
          create: (_) => DayPickerBloc(storageService: storageService)
            ..add(
              DayAppStateChanged(),
            ),
        ),

        /// Bloc intended to manage the forecast displayed
        BlocProvider(
          create: (_) => ChabanBridgeForecastBloc(
            httpClient: http.Client(),
            notificationService:
                NotificationService(storageService: storageService),
          )..add(
              ChabanBridgeForecastFetched(),
            ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData,
            home: const ChabanBridgeForecastScreen(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
            ],
          );
        },
      ),
    );
  }
}
