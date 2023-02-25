part of 'day_picker_bloc.dart';

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension DayExtension on Day? {
  String name(BuildContext context) {
    switch (this) {
      case Day.monday:
        return AppLocalizations.of(context)!.monday;
      case Day.tuesday:
        return AppLocalizations.of(context)!.tuesday;
      case Day.wednesday:
        return AppLocalizations.of(context)!.wednesday;
      case Day.thursday:
        return AppLocalizations.of(context)!.thursday;
      case Day.friday:
        return AppLocalizations.of(context)!.friday;
      case Day.saturday:
        return AppLocalizations.of(context)!.saturday;
      case Day.sunday:
        return AppLocalizations.of(context)!.sunday;
      case null:
        throw Exception('Day not defined for null');
    }
  }
}

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
