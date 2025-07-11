part of 'time_slots_bloc.dart';

class TimeSlotsState extends Equatable {
  final List<TimeSlot> timeSlots;
  final List<Day> days;

  const TimeSlotsState({required this.timeSlots, required this.days});

  TimeSlotsState copyWith({List<TimeSlot>? timeSlots, List<Day>? days}) {
    return TimeSlotsState(
      timeSlots: timeSlots ?? this.timeSlots,
      days: days ?? this.days,
    );
  }

  @override
  List<Object?> get props => [timeSlots, days];
}

class TimeSlotsInitial extends TimeSlotsState {
  TimeSlotsInitial()
    : super(
        timeSlots: Const.notificationFavoriteSlotsDefaultValue,
        days: Const.notificationFavoriteSlotsDaysDefaultValue,
      );
}
