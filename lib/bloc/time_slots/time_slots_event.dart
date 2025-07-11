part of 'time_slots_bloc.dart';

class TimeSlotsEvent extends ChaboEvent {}

class TimeSlotChanged extends TimeSlotsEvent {
  final TimeSlot timeSlot;
  final int index;

  TimeSlotChanged({required this.timeSlot, required this.index}) : super();
}

class DaysChanged extends TimeSlotsEvent {
  final Day day;
  final bool isSelected;

  DaysChanged({required this.day, required this.isSelected}) : super();
}

class TimeSlotsAppEvent extends TimeSlotsEvent {
  TimeSlotsAppEvent() : super();
}
