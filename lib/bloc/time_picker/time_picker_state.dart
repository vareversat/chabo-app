part of 'time_picker_bloc.dart';

class TimePickerState {
  final bool enabled;
  final Duration time;

  TimePickerState({required this.enabled, required this.time});

  TimePickerState copyWith({Duration? time, bool? enabled}) {
    return TimePickerState(
        time: time ?? this.time, enabled: enabled ?? this.enabled);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: time.inHours, minute: time.inMinutes % 60);
  }

  String getDuration() {
    if (time.inMinutes % 60 == 0) {
      return '${time.inHours.toString()}h';
    } else if (time.inHours == 0) {
      return '${time.inMinutes.toString()}mins';
    }
    return '${time.inHours.toString()}h ${(time.inMinutes % 60).toString()}mins';
  }
}
