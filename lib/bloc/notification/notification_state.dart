part of 'notification_bloc.dart';

class NotificationState {
  final bool durationNotificationEnabled;
  final Duration durationNotificationValue;
  final bool timeNotificationEnabled;
  final TimeOfDay timeNotificationValue;
  final bool dayNotificationEnabled;
  final Day dayNotificationValue;
  final TimeOfDay dayNotificationTimeValue;
  final bool openingNotificationEnabled;
  final bool closingNotificationEnabled;
  final bool timeSlotsEnabledForNotifications;
  final List<TimeSlot> timeSlotsValue;

  NotificationState({
    required this.durationNotificationEnabled,
    required this.durationNotificationValue,
    required this.timeNotificationEnabled,
    required this.timeNotificationValue,
    required this.dayNotificationEnabled,
    required this.dayNotificationValue,
    required this.dayNotificationTimeValue,
    required this.openingNotificationEnabled,
    required this.closingNotificationEnabled,
    required this.timeSlotsEnabledForNotifications,
    required this.timeSlotsValue,
  });

  NotificationState copyWith({
    bool? durationNotificationEnabled,
    Duration? durationNotificationValue,
    bool? timeNotificationEnabled,
    TimeOfDay? timeNotificationValue,
    bool? dayNotificationEnabled,
    Day? dayNotificationValue,
    TimeOfDay? dayNotificationTimeValue,
    bool? openingNotificationEnabled,
    bool? closingNotificationEnabled,
    bool? timeSlotsEnabledForNotifications,
    List<TimeSlot>? timeSlotsValue,
  }) {
    return NotificationState(
      durationNotificationEnabled:
          durationNotificationEnabled ?? this.durationNotificationEnabled,
      durationNotificationValue:
          durationNotificationValue ?? this.durationNotificationValue,
      timeNotificationEnabled:
          timeNotificationEnabled ?? this.timeNotificationEnabled,
      timeNotificationValue:
          timeNotificationValue ?? this.timeNotificationValue,
      dayNotificationEnabled:
          dayNotificationEnabled ?? this.dayNotificationEnabled,
      dayNotificationValue: dayNotificationValue ?? this.dayNotificationValue,
      dayNotificationTimeValue:
          dayNotificationTimeValue ?? this.dayNotificationTimeValue,
      openingNotificationEnabled:
          openingNotificationEnabled ?? this.openingNotificationEnabled,
      closingNotificationEnabled:
          closingNotificationEnabled ?? this.closingNotificationEnabled,
      timeSlotsEnabledForNotifications: timeSlotsEnabledForNotifications ??
          this.timeSlotsEnabledForNotifications,
      timeSlotsValue: timeSlotsValue ?? this.timeSlotsValue,
    );
  }
}
