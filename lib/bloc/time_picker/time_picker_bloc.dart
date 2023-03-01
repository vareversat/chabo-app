import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_picker_event.dart';
part 'time_picker_state.dart';

class TimePickerBloc extends Bloc<TimePickerEvent, TimePickerState> {
  final StorageService storageService;

  TimePickerBloc({required this.storageService})
      : super(
            TimePickerState(time: const Duration(hours: 20), enabled: false)) {
    on<TimePickerChanged>(
      _onTimePickerChanged,
    );
    on<TimePickerStateChanged>(
      _onStateChanged,
    );
    on<TimeAppStateChanged>(
      _onAppStateChanged,
    );
  }

  Future<void> _onTimePickerChanged(
      TimePickerChanged event, Emitter<TimePickerState> emit) async {
    await storageService.saveDuration(
        Const.notificationTimeValueKey, event.time);
    emit(
      state.copyWith(time: event.time),
    );
  }

  Future<void> _onStateChanged(
      TimePickerStateChanged event, Emitter<TimePickerState> emit) async {
    await storageService.saveBool(
        Const.notificationTimeEnabledKey, event.enabled);
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }

  Future<void> _onAppStateChanged(
      TimeAppStateChanged event, Emitter<TimePickerState> emit) async {
    final time = storageService.readDuration(Const.notificationTimeValueKey) ??
        Const.notificationTimeValueDefaultValue;
    final enabledValue =
        storageService.readBool(Const.notificationTimeEnabledKey) ??
            Const.notificationTimeEnabledDefaultValue;
    emit(
      state.copyWith(enabled: enabledValue, time: time),
    );
  }
}
