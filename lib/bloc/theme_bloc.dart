import 'package:chabo/app_theme.dart';
import 'package:chabo/const.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences localStorage;

  ThemeBloc({required this.localStorage})
      : super(ThemeState(themeData: AppThemes.lightTheme)) {
    on<ThemeChanged>(
      _onThemeChanged,
    );
    on<AppStateChanged>(
      _onAppStateChanged,
    );
  }

  ThemeData _getCorrectThemeForSystem() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
  }

  Future<void> _onAppStateChanged(
      AppStateChanged event, Emitter<ThemeState> emit) async {
    var savedStatus = localStorage.getString(Const.storageThemeKey);
    if (savedStatus == null) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.system,
          themeData: _getCorrectThemeForSystem(),
        ),
      );
    } else {
      var status =
          EnumToString.fromString(ThemeStateStatus.values, savedStatus);
      if (status == ThemeStateStatus.light) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.light,
            themeData: AppThemes.lightTheme,
          ),
        );
      } else if (status == ThemeStateStatus.dark) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.dark,
            themeData: AppThemes.darkTheme,
          ),
        );
      } else if (status == ThemeStateStatus.system) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.system,
            themeData: _getCorrectThemeForSystem(),
          ),
        );
      }
    }
  }

  Future<void> _onThemeChanged(
      ThemeChanged event, Emitter<ThemeState> emit) async {
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
      emit(
        state.copyWith(
          status: ThemeStateStatus.system,
          themeData: _getCorrectThemeForSystem(),
        ),
      );
    }
  }
}
