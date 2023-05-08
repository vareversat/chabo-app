part of 'time_slot_bloc.dart';

@immutable
abstract class TimeSlotEvent extends ChaboEvent {}

class EnabledTimeSlotEvent extends TimeSlotEvent {
  final bool enabled;

  EnabledTimeSlotEvent({required this.enabled}) : super();
}

class ValueTimeSlotEvent extends TimeSlotEvent {
  final TimeSlot timeSlot;
  final int index;

  ValueTimeSlotEvent({required this.timeSlot, required this.index}) : super();
}

class TimeSlotAppEvent extends TimeSlotEvent {
  TimeSlotAppEvent() : super();
}
