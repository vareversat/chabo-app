part of 'time_picker_bloc.dart';

class TimePickerState {
  final bool enabled;
  final TimeOfDay tod;

  TimePickerState({required this.enabled, required this.tod});

  TimePickerState copyWith({TimeOfDay? tod, bool? enabled}) {
    return TimePickerState(
        tod: tod ?? this.tod, enabled: enabled ?? this.enabled);
  }

  String getFormattedTof(BuildContext context) {
    return tod.format(context);
  }

  String getTof() {
    if (tod.hour > 0 && tod.minute == 0) {
      return '${tod.hour.toString()}h';
    } else if (tod.hour == 0 && tod.minute > 0) {
      return '${tod.minute.toString()}mins';
    } else {
      return '${tod.hour.toString()}h ${tod.minute.toString()}mins';
    }
  }
}
