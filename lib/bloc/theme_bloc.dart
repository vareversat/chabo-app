import 'package:chabo/app_theme.dart';
import 'package:chabo/const.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppThemes.lightTheme)) {
    on<ThemeChanged>(
      _onThemeChanged,
    );
  }

  Future<void> _onThemeChanged(
      ThemeChanged event, Emitter<ThemeState> emit) async {
    var localStorage = await SharedPreferences.getInstance();
    localStorage.setString(
      Const.storageThemeKey,
      EnumToString.convertToString(event.status),
    );
    if (event.status == ThemeStateStatus.light) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.light,
          themeData: AppThemes.lightTheme,
        ),
      );
    } else if (event.status == ThemeStateStatus.dark) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.dark,
          themeData: AppThemes.darkTheme,
        ),
      );
    } else if (event.status == ThemeStateStatus.system) {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      emit(
        state.copyWith(
          status: ThemeStateStatus.system,
          themeData: isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
        ),
      );
    }
  }
}
