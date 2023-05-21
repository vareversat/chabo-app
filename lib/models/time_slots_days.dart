import 'package:chabo/models/enums/day.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

class TimeSlotsDays extends Equatable {
  final Map<Day, bool> days;

  const TimeSlotsDays({required this.days});

  Map<dynamic, String> toJson() {
    return days.map((key, value) =>
        MapEntry(EnumToString.convertToString(key), value.toString()));
  }

  factory TimeSlotsDays.fromJson(Map<dynamic, dynamic> json) {
    final days = json.map((key, value) =>
        MapEntry(EnumToString.fromString(Day.values, key)!, value == 'true'));

    return TimeSlotsDays(days: days);
  }

  void setSelected(Day day, bool isSelected) {
    days[day] = isSelected;
  }

  @override
  List<Object?> get props => [days];
}
