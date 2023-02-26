import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'duration_picker_event.dart';

part 'duration_picker_state.dart';

class DurationPickerBloc
    extends Bloc<DurationPickerEvent, DurationPickerState> {
  final StorageService storageService;

  DurationPickerBloc({required this.storageService})
      : super(
          DurationPickerState(
            duration: const Duration(hours: 1),
            enabled: false,
          ),
        ) {
    on<DurationPickerChanged>(
      _onDurationChanged,
    );
    on<DurationPickerStateChanged>(
      _onStateChanged,
    );
    on<DurationAppStateChanged>(
      _onAppStateChanged,
    );
  }

  Future<void> _onDurationChanged(
      DurationPickerChanged event, Emitter<DurationPickerState> emit) async {
    await storageService.saveDuration(
        Const.notificationDurationValueKey, event.duration);
    emit(
      state.copyWith(duration: event.duration),
    );
  }

  Future<void> _onStateChanged(DurationPickerStateChanged event,
      Emitter<DurationPickerState> emit) async {
    await storageService.saveBool(
        Const.notificationDurationEnabledKey, event.enabled);
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }

  Future<void> _onAppStateChanged(
      DurationAppStateChanged event, Emitter<DurationPickerState> emit) async {
    final durationValue =
        storageService.readDuration(Const.notificationDurationValueKey) ??
            Const.notificationDurationValueDefaultValue;
    final enabledValue =
        storageService.readBool(Const.notificationDurationEnabledKey) ??
            Const.notificationDurationEnabledDefaultValue;
    emit(
      state.copyWith(enabled: enabledValue, duration: durationValue),
    );
  }
}
