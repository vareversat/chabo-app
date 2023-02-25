part of 'day_picker_bloc.dart';

class DayPickerEvent extends ChaboEvent {}

class DayPickerSettingChanged extends DayPickerEvent {
  final bool isOpen;

  DayPickerSettingChanged({required this.isOpen}) : super();
}

class DayPickerChanged extends DayPickerEvent {
  final Day day;

  DayPickerChanged({required this.day}) : super();
}

class DayPickerStateChanged extends DayPickerEvent {
  final bool enabled;

  DayPickerStateChanged({required this.enabled}) : super();
}
