import 'package:chabo_app/app_theme.dart';
import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:chabo_app/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo_app/cubits/floating_actions_cubit.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/screens/forecast_screen.dart';
import 'package:chabo_app/service/notification_service.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Chabo extends StatelessWidget {
  final StorageService storageService;
  final NotificationService notificationService;

  const Chabo({
    super.key,
    required this.storageService,
    required this.notificationService,
  });

  @override
  Widget build(BuildContext context) {
    DeviceHelper.computePreferredOrientation(context);

    return MultiBlocProvider(
      providers: [
        /// Bloc intended to manage the theme of the App
        BlocProvider(
          create: (_) => ThemeBloc(
            storageService: storageService,
          )..add(
              AppStateChanged(),
            ),
        ),

        /// Bloc intended to manage the FloatingActions
        BlocProvider(
          create: (_) => FloatingActionsCubit(
            storageService,
            const FloatingActionsState(isMenuOpen: false, isRightHanded: true),
          )..init(),
        ),

        /// Bloc intended to manage the displayed time format
        BlocProvider(
          create: (_) => TimeFormatCubit(
            storageService,
            const TimeFormatState(timeFormat: TimeFormat.twentyFourHours),
          )..init(),
        ),

        /// Bloc intended to manage the forecast displayed
        BlocProvider(
          create: (_) => ForecastBloc(
            httpClient: SentryHttpClient(),
          )..add(
              ForecastFetched(),
            ),
        ),

        /// Bloc intended to manage the status
        BlocProvider(
          create: (_) => StatusBloc(),
        ),

        /// Bloc intended to manage scroll to status to display (or not) the current status
        BlocProvider(
          create: (_) => ScrollStatusBloc(
            scrollController: ScrollController(),
          ),
        ),

        /// Bloc intended to manage all Notifications
        BlocProvider(
          create: (_) => NotificationBloc(
            storageService: storageService,
            notificationService: notificationService,
          )..add(
              NotificationAppEvent(),
            ),
        ),

        /// Bloc intended to manage all TimeSlots
        BlocProvider(
          create: (_) => TimeSlotsBloc(
            storageService: storageService,
          )..add(
              TimeSlotsAppEvent(),
            ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: false,
              statusBarIconBrightness: state.themeData == AppTheme.darkTheme
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            navigatorObservers: [
              SentryNavigatorObserver(
                setRouteNameAsTransaction: true,
              ),
            ],
            initialRoute: ForecastScreen.routeName,
            routes: {
              ForecastScreen.routeName: (context) => const ForecastScreen(),
            },
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
