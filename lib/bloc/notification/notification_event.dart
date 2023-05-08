part of 'notification_bloc.dart';

class NotificationEvent extends ChaboEvent {}

class OpeningNotificationStateEvent extends NotificationEvent {
  final bool enabled;

  OpeningNotificationStateEvent({required this.enabled}) : super();
}

class ClosingNotificationStateEvent extends NotificationEvent {
  final bool enabled;

  ClosingNotificationStateEvent({required this.enabled}) : super();
}

class DayNotificationStateEvent extends NotificationEvent {
  final bool enabled;

  DayNotificationStateEvent({required this.enabled}) : super();
}

class TimeNotificationStateEvent extends NotificationEvent {
  final bool enabled;

  TimeNotificationStateEvent({required this.enabled}) : super();
}

class DurationNotificationStateEvent extends NotificationEvent {
  final bool enabled;

  DurationNotificationStateEvent({required this.enabled}) : super();
}

class DayNotificationValueEvent extends NotificationEvent {
  final Day day;

  DayNotificationValueEvent({required this.day}) : super();
}

class DayNotificationTimeValueEvent extends NotificationEvent {
  final TimeOfDay time;

  DayNotificationTimeValueEvent({required this.time}) : super();
}

class DurationNotificationValueEvent extends NotificationEvent {
  final Duration duration;

  DurationNotificationValueEvent({required this.duration}) : super();
}

class TimeNotificationValueEvent extends NotificationEvent {
  final TimeOfDay time;

  TimeNotificationValueEvent({required this.time}) : super();
}

class EnabledTimeSlotEvent extends NotificationEvent {
  final bool enabled;

  EnabledTimeSlotEvent({required this.enabled}) : super();
}

class ValueTimeSlotEvent extends NotificationEvent {
  final TimeSlot timeSlot;
  final int index;

  ValueTimeSlotEvent({required this.timeSlot, required this.index}) : super();
}

class AppEvent extends NotificationEvent {
  AppEvent() : super();
}
