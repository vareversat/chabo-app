import 'package:chabo/bloc/chabo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_picker_event.dart';
part 'time_picker_state.dart';

class TimePickerBloc extends Bloc<TimePickerEvent, TimePickerState> {
  TimePickerBloc()
      : super(TimePickerState(tof: TimeOfDay.now(), enabled: false)) {
    on<TimePickerChanged>(
      _onTimePickerChanged,
    );
    on<TimePickerStateChanged>(
      _onStateChanged,
    );
  }

  Future<void> _onTimePickerChanged(
      TimePickerChanged event, Emitter<TimePickerState> emit) async {
    emit(
      state.copyWith(tof: event.tof),
    );
  }

  Future<void> _onStateChanged(
      TimePickerStateChanged event, Emitter<TimePickerState> emit) async {
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }
}
