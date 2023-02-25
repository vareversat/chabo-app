part of 'time_picker_bloc.dart';

class TimePickerEvent extends ChaboEvent {}

class TimePickerChanged extends TimePickerEvent {
  final TimeOfDay tof;

  TimePickerChanged({required this.tof}) : super();
}

class TimePickerStateChanged extends TimePickerEvent {
  final bool enabled;

  TimePickerStateChanged({required this.enabled}) : super();
}
