part of 'duration_picker_bloc.dart';

class DurationPickerState {
  final bool enabled;
  final Duration duration;

  DurationPickerState({required this.enabled, required this.duration});

  DurationPickerState copyWith({Duration? duration, bool? enabled}) {
    return DurationPickerState(
        duration: duration ?? this.duration, enabled: enabled ?? this.enabled);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: duration.inHours, minute: duration.inMinutes % 60);
  }

  String getDuration() {
    if (duration.inMinutes % 60 == 0) {
      return "${duration.inHours.toString()}h";
    } else if (duration.inHours == 0) {
      return "${duration.inMinutes.toString()}mins";
    }
    return "${duration.inHours.toString()}h ${(duration.inMinutes % 60).toString()}mins";
  }
}
