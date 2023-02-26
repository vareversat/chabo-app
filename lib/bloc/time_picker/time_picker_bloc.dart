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
      : super(TimePickerState(tod: TimeOfDay.now(), enabled: false)) {
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
    await storageService.saveTimeOfDay(
        Const.notificationTimeValueKey, event.tod);
    emit(
      state.copyWith(tod: event.tod),
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
    final todValue =
        storageService.readTimeOfDay(Const.notificationTimeValueKey) ??
            Const.notificationTimeValueDefaultValue;
    final enabledValue =
        storageService.readBool(Const.notificationTimeEnabledKey) ??
            Const.notificationTimeEnabledDefaultValue;
    emit(
      state.copyWith(enabled: enabledValue, tod: todValue),
    );
  }
}
