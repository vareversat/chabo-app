part of 'day_picker_bloc.dart';

class DayPickerState {
  final IconData icon;
  final Day day;
  final bool enabled;

  DayPickerState(
      {required this.enabled, required this.day, required this.icon});

  DayPickerState copyWith({Day? day, bool? enabled, IconData? icon}) {
    return DayPickerState(
        day: day ?? this.day,
        enabled: enabled ?? this.enabled,
        icon: icon ?? this.icon);
  }
}
