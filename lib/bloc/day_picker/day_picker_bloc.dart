import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'day_picker_event.dart';

part 'day_picker_state.dart';

class DayPickerBloc extends Bloc<DayPickerEvent, DayPickerState> {
  final StorageService storageService;

  DayPickerBloc({required this.storageService})
      : super(
            DayPickerState(day: Day.monday, enabled: false, icon: Icons.edit)) {
    on<DayPickerChanged>(
      _onDayChanged,
    );
    on<DayPickerStateChanged>(
      _onStateChanged,
    );
    on<DayPickerSettingChanged>(
      _onSettingsChanged,
    );
    on<DayAppStateChanged>(
      _onAppStateChanged,
    );
  }

  Future<void> _onDayChanged(
      DayPickerChanged event, Emitter<DayPickerState> emit) async {
    await storageService.saveDay(Const.notificationDayValueKey, event.day);
    emit(
      state.copyWith(day: event.day),
    );
  }

  Future<void> _onStateChanged(
      DayPickerStateChanged event, Emitter<DayPickerState> emit) async {
    await storageService.saveBool(
        Const.notificationDayEnabledKey, event.enabled);
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }

  Future<void> _onSettingsChanged(
      DayPickerSettingChanged event, Emitter<DayPickerState> emit) async {
    emit(
      state.copyWith(icon: event.isOpen ? Icons.close : Icons.edit),
    );
  }

  Future<void> _onAppStateChanged(
      DayAppStateChanged event, Emitter<DayPickerState> emit) async {
    final dayValue = storageService.readDay(Const.notificationDayValueKey) ??
        Const.notificationDayValueDefaultValue;
    final enabledValue =
        storageService.readBool(Const.notificationDayEnabledKey) ??
            Const.notificationDayEnabledDefaultValue;
    emit(
      state.copyWith(enabled: enabledValue, day: dayValue),
    );
  }
}
