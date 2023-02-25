import 'package:chabo/bloc/chabo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'duration_picker_event.dart';
part 'duration_picker_state.dart';

class DurationPickerBloc
    extends Bloc<DurationPickerEvent, DurationPickerState> {
  DurationPickerBloc()
      : super(DurationPickerState(
            duration: const Duration(hours: 1), enabled: false)) {
    on<DurationPickerChanged>(
      _onDurationChanged,
    );
    on<DurationPickerStateChanged>(
      _onStateChanged,
    );
  }

  Future<void> _onDurationChanged(
      DurationPickerChanged event, Emitter<DurationPickerState> emit) async {
    emit(
      state.copyWith(duration: event.duration),
    );
  }

  Future<void> _onStateChanged(DurationPickerStateChanged event,
      Emitter<DurationPickerState> emit) async {
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }
}
