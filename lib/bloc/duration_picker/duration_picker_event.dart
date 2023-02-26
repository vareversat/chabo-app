part of 'duration_picker_bloc.dart';

class DurationPickerEvent extends ChaboEvent {}

class DurationPickerChanged extends DurationPickerEvent {
  final Duration duration;

  DurationPickerChanged({required this.duration}) : super();
}

class DurationPickerStateChanged extends DurationPickerEvent {
  final bool enabled;

  DurationPickerStateChanged({required this.enabled}) : super();
}

class DurationAppStateChanged extends DurationPickerEvent {
  DurationAppStateChanged() : super();
}
