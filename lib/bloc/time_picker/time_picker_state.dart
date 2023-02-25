part of 'time_picker_bloc.dart';

class TimePickerState {
  final bool enabled;
  final TimeOfDay tof;

  TimePickerState({required this.enabled, required this.tof});

  TimePickerState copyWith({TimeOfDay? tof, bool? enabled}) {
    return TimePickerState(
        tof: tof ?? this.tof, enabled: enabled ?? this.enabled);
  }

  String getFormattedTof(BuildContext context) {
    return tof.format(context);
  }

  String getTof() {
    if (tof.hour > 0 && tof.minute == 0) {
      return "${tof.hour.toString()}h";
    } else if (tof.hour == 0 && tof.minute > 0) {
      return "${tof.minute.toString()}mins";
    } else {
      return "${tof.hour.toString()}h ${tof.minute.toString()}mins";
    }
  }
}
