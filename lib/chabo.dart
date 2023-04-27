import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/chaban_bridge_status/chaban_bridge_status_bloc.dart';
import 'package:chabo/cubits/floating_actions_cubit.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/cubits/notification_service_cubit.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/bloc/theme/theme_bloc.dart';
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
  final NotificationService notificationService;

  const Chabo({
    Key? key,
    required this.storageService,
    required this.notificationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

        /// Bloc intended to manage the Notifications service
        BlocProvider(
          create: (_) => NotificationServiceCubit(
            notificationService,
          ),
        ),

        /// Bloc intended to manage the FloatingActions
        BlocProvider(
          create: (_) => FloatingActionsCubit(
            storageService,
            const FloatingActionsState(isMenuOpen: false, isRightHanded: true),
          )..init(),
        ),

        /// Bloc intended to manage the forecast displayed
        BlocProvider(
          create: (_) => ChabanBridgeForecastBloc(
            httpClient: http.Client(),
          )..add(
              ChabanBridgeForecastFetched(),
            ),
        ),

        /// Bloc intended to manage the status
        BlocProvider(
          create: (_) => ChabanBridgeStatusBloc(),
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
          )..add(
              AppEvent(),
            ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
