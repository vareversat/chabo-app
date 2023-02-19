import 'package:chabo/bloc/theme_bloc.dart';
import 'package:chabo/const.dart';
import 'package:chabo/screens/chaban_bridge_forecast_screen.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  ThemeStateStatus _getThemeInitialStatus(String? savedStatus) {
    if (savedStatus == null) {
      return ThemeStateStatus.system;
    } else {
      return EnumToString.fromString(ThemeStateStatus.values, savedStatus)!;
    }

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            create: (_) => ThemeBloc()
              ..add(
                ThemeChanged(
                  status: _getThemeInitialStatus(snapshot.data?.getString(Const.storageThemeKey)),
                ),
              ),
            child:
                BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
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
            }),
          );
        } else if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ErrorScreen(
            errorMessage: snapshot.error.toString(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
