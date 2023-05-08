part of 'time_slot_bloc.dart';

class TimeSlotState extends Equatable {
  final List<TimeSlot> timeSlots;
  final bool enabledForNotifications;

  const TimeSlotState({
    required this.timeSlots,
    required this.enabledForNotifications,
  });

  TimeSlotState copyWith({
    List<TimeSlot>? timeSlots,
    bool? enabledForNotifications,
  }) {
    return TimeSlotState(
      timeSlots: timeSlots ?? this.timeSlots,
      enabledForNotifications:
          enabledForNotifications ?? this.enabledForNotifications,
    );
  }

  @override
  List<Object?> get props => [timeSlots, enabledForNotifications];
}
