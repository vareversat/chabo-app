import 'package:chabo/app_theme.dart';
import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/enums/theme_state_status.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService storageService;

  ThemeBloc({required this.storageService})
      : super(ThemeState(themeData: AppTheme.lightTheme)) {
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

    return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  void _onAppStateChanged(
    AppStateChanged event,
    Emitter<ThemeState> emit,
  ) {
    var savedStatus = storageService.readTheme(Const.storageThemeKey);
    if (savedStatus == null) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.system,
          themeData: _getCorrectThemeForSystem(),
        ),
      );
    } else {
      if (savedStatus == ThemeStateStatus.light) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.light,
            themeData: AppTheme.lightTheme,
          ),
        );
      } else if (savedStatus == ThemeStateStatus.dark) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.dark,
            themeData: AppTheme.darkTheme,
          ),
        );
      } else if (savedStatus == ThemeStateStatus.system) {
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
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    await storageService.saveTheme(
      Const.storageThemeKey,
      event.status,
    );
    if (event.status == ThemeStateStatus.light) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.light,
          themeData: AppTheme.lightTheme,
        ),
      );
    } else if (event.status == ThemeStateStatus.dark) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.dark,
          themeData: AppTheme.darkTheme,
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
