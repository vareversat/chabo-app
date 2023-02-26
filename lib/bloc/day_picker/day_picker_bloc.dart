import 'package:chabo/bloc/chabo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'day_picker_event.dart';

part 'day_picker_state.dart';

class DayPickerBloc extends Bloc<DayPickerEvent, DayPickerState> {
  DayPickerBloc()
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
  }

  Future<void> _onDayChanged(
      DayPickerChanged event, Emitter<DayPickerState> emit) async {
    emit(
      state.copyWith(day: event.day),
    );
  }

  Future<void> _onStateChanged(
      DayPickerStateChanged event, Emitter<DayPickerState> emit) async {
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
}
