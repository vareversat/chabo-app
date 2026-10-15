import 'package:chabo_app/app_theme.dart';
import 'package:chabo_app/bloc/chabo_event.dart';
import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/const.dart';
import 'package:chabo_app/models/enums/theme_state_status.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService storageService;
  final MaterialTheme theme;

  ThemeBloc({required this.storageService, required this.theme})
    : super(
        ThemeState(
          themeData: theme.light(),
          imagePath: Const.chaboPhotoDayOpen,
          imageCredits: Const.chaboPhotoDayOpenCredits,
          imageCreditsLink: Const.chaboPhotoDayOpenCreditsLink,
          bridgeState: BridgeState.open,
        ),
      ) {
    on<ThemeChanged>(_onThemeChanged);
    on<AppStateChanged>(_onAppStateChanged);
    on<BridgeStateChanged>(_onBridgeStatChanged);
  }

  ThemeData _getCorrectThemeForSystem() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? theme.dark() : theme.light();
  }

  _ImageData _getCorrectImageData(ThemeStateStatus themeStatus) {
    bool isDarkMode;
    if (themeStatus == ThemeStateStatus.system) {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    } else {
      isDarkMode = themeStatus == ThemeStateStatus.dark;
    }

    if (state.bridgeState == BridgeState.closed) {
      if (isDarkMode) {
        return _ImageData(
          path: Const.chaboPhotoNightClosed,
          credits: Const.chaboPhotoNightClosedCredits,
          creditsLink: Const.chaboPhotoNightClosedCreditsLink,
        );
      } else {
        return _ImageData(
          path: Const.chaboPhotoDayClosed,
          credits: Const.chaboPhotoDayClosedCredits,
          creditsLink: Const.chaboPhotoDayClosedCreditsLink,
        );
      }
    } else {
      if (isDarkMode) {
        return _ImageData(
          path: Const.chaboPhotoNightOpen,
          credits: Const.chaboPhotoNightOpenCredits,
          creditsLink: Const.chaboPhotoNightOpenCreditsLink,
        );
      } else {
        return _ImageData(
          path: Const.chaboPhotoDayOpen,
          credits: Const.chaboPhotoDayOpenCredits,
          creditsLink: Const.chaboPhotoDayOpenCreditsLink,
        );
      }
    }
  }

  void _onAppStateChanged(AppStateChanged event, Emitter<ThemeState> emit) {
    var savedStatus = storageService.readTheme(Const.storageThemeKey);
    if (savedStatus == null) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.system,
          themeData: _getCorrectThemeForSystem(),
          imagePath: _getCorrectImageData(ThemeStateStatus.system).path,
          imageCredits: _getCorrectImageData(ThemeStateStatus.system).credits,
          imageCreditsLink: _getCorrectImageData(ThemeStateStatus.system)
              .creditsLink,
        ),
      );
    } else {
      if (savedStatus == ThemeStateStatus.light) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.light,
            themeData: theme.light(),
            imagePath: _getCorrectImageData(ThemeStateStatus.light).path,
            imageCredits: _getCorrectImageData(ThemeStateStatus.light).credits,
            imageCreditsLink: _getCorrectImageData(ThemeStateStatus.light)
                .creditsLink,
          ),
        );
      } else if (savedStatus == ThemeStateStatus.dark) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.dark,
            themeData: theme.dark(),
            imagePath: _getCorrectImageData(ThemeStateStatus.dark).path,
            imageCredits: _getCorrectImageData(ThemeStateStatus.dark).credits,
            imageCreditsLink: _getCorrectImageData(ThemeStateStatus.dark)
                .creditsLink,
          ),
        );
      } else if (savedStatus == ThemeStateStatus.system) {
        emit(
          state.copyWith(
            status: ThemeStateStatus.system,
            themeData: _getCorrectThemeForSystem(),
            imagePath: _getCorrectImageData(ThemeStateStatus.system).path,
            imageCredits: _getCorrectImageData(ThemeStateStatus.system).credits,
            imageCreditsLink: _getCorrectImageData(ThemeStateStatus.system)
                .creditsLink,
          ),
        );
      }
    }
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    await storageService.saveTheme(Const.storageThemeKey, event.status);
    if (event.status == ThemeStateStatus.light) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.light,
          themeData: theme.light(),
          imagePath: _getCorrectImageData(ThemeStateStatus.light).path,
          imageCredits: _getCorrectImageData(ThemeStateStatus.light).credits,
          imageCreditsLink: _getCorrectImageData(ThemeStateStatus.light)
              .creditsLink,
        ),
      );
    } else if (event.status == ThemeStateStatus.dark) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.dark,
          themeData: theme.dark(),
          imagePath: _getCorrectImageData(ThemeStateStatus.dark).path,
          imageCredits: _getCorrectImageData(ThemeStateStatus.dark).credits,
          imageCreditsLink: _getCorrectImageData(ThemeStateStatus.dark)
              .creditsLink,
        ),
      );
    } else if (event.status == ThemeStateStatus.system) {
      emit(
        state.copyWith(
          status: ThemeStateStatus.system,
          themeData: _getCorrectThemeForSystem(),
          imagePath: _getCorrectImageData(ThemeStateStatus.system).path,
          imageCredits: _getCorrectImageData(ThemeStateStatus.system).credits,
          imageCreditsLink: _getCorrectImageData(ThemeStateStatus.system)
              .creditsLink,
        ),
      );
    }
  }

  Future<void> _onBridgeStatChanged(
    BridgeStateChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      state.copyWith(
        bridgeState: event.bridgeState,
        imagePath: _getCorrectImageData(state.status).path,
        imageCredits: _getCorrectImageData(state.status).credits,
        imageCreditsLink: _getCorrectImageData(state.status).creditsLink,
      ),
    );
  }
}

class _ImageData {
  final String path;
  final String credits;
  final String creditsLink;

  _ImageData({
    required this.path,
    required this.credits,
    required this.creditsLink,
  });
}
