import 'package:chabo_app/app_theme.dart';
import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:chabo_app/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/service/forecast_cache_service.dart';
import 'package:chabo_app/service/notification_service.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:chabo_app/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'screens/main_screen.dart';

class Chabo extends StatelessWidget {
  final StorageService storageService;
  final NotificationService notificationService;
  final ForecastCacheService forecastCacheService;

  Chabo({
    super.key,
    required this.storageService,
    required this.notificationService,
    ForecastCacheService? forecastCacheService,
  }) : forecastCacheService =
           forecastCacheService ?? ForecastCacheService();

  @override
  Widget build(BuildContext context) {
    DeviceHelper.computePreferredOrientation(context);
    TextTheme textTheme = createTextTheme(
      context,
      'Libre Franklin',
      'Josefin Sans',
    );
    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        /// Bloc intended to manage the navigation of the app
        BlocProvider(create: (_) => NavBloc()),

        /// Bloc intended to manage the theme of the App
        BlocProvider(
          create: (_) =>
              ThemeBloc(storageService: storageService, theme: theme)
                ..add(AppStateChanged()),
        ),

        /// Bloc intended to manage the displayed time format
        BlocProvider(
          create: (_) => TimeFormatCubit(
            storageService,
            const TimeFormatState(timeFormat: TimeFormat.twentyFourHours),
          )..init(),
        ),

        /// Bloc intended to manage the forecast displayed.
        /// Data is fetched from the Bordeaux Metropole opendata REST API and
        /// transparently cached on disk (via flutter_cache_manager) so it stays
        /// available offline or when the API is down.
        BlocProvider(
          create: (_) => ForecastBloc(
            httpClient: SentryHttpClient(),
            cacheService: forecastCacheService,
          )..add(ForecastFetched()),
        ),

        /// Bloc intended to manage the status
        BlocProvider(create: (_) => StatusBloc()),

        /// Bloc intended to manage all Notifications
        BlocProvider(
          create: (_) => NotificationBloc(
            storageService: storageService,
            notificationService: notificationService,
          )..add(NotificationAppEvent()),
        ),

        /// Bloc intended to manage all TimeSlots
        BlocProvider(
          create: (_) =>
              TimeSlotsBloc(storageService: storageService)
                ..add(TimeSlotsAppEvent()),
        ),

        /// Bloc intended to the NavBar
        BlocProvider(create: (_) => NavBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: false,
              statusBarIconBrightness: state.themeData == theme.dark()
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            navigatorObservers: [
              SentryNavigatorObserver(setRouteNameAsTransaction: true),
            ],
            home: const MainScreen(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
              Locale('es', ''),
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale!.languageCode) {
                  return deviceLocale;
                }
              }

              return const Locale('en', '');
            },
          );
        },
      ),
    );
  }
}
