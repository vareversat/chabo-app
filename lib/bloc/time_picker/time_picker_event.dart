part of 'time_picker_bloc.dart';

class TimePickerEvent extends ChaboEvent {}

class TimePickerChanged extends TimePickerEvent {
  final TimeOfDay tod;

  TimePickerChanged({required this.tod}) : super();
}

class TimePickerStateChanged extends TimePickerEvent {
  final bool enabled;

  TimePickerStateChanged({required this.enabled}) : super();
}

class TimeAppStateChanged extends TimePickerEvent {
  TimeAppStateChanged() : super();
}
