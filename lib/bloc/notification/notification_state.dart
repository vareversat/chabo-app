part of 'notification_bloc.dart';

class NotificationSate {
  final bool durationNotificationEnabled;
  final Duration durationNotificationValue;
  final bool timeNotificationEnabled;
  final Duration timeNotificationValue;
  final bool dayNotificationEnabled;
  final Day dayNotificationValue;
  final TimeOfDay dayNotificationTimeValue =
      const TimeOfDay(hour: 20, minute: 00);
  final bool openingNotificationEnabled;
  final bool closingNotificationEnabled;

  NotificationSate(
      {required this.durationNotificationEnabled,
      required this.durationNotificationValue,
      required this.timeNotificationEnabled,
      required this.timeNotificationValue,
      required this.dayNotificationEnabled,
      required this.dayNotificationValue,
      required this.openingNotificationEnabled,
      required this.closingNotificationEnabled});

  NotificationSate copyWith(
      {bool? durationNotificationEnabled,
      Duration? durationNotificationValue,
      bool? timeNotificationEnabled,
      Duration? timeNotificationValue,
      bool? dayNotificationEnabled,
      Day? dayNotificationValue,
      bool? openingNotificationEnabled,
      bool? closingNotificationEnabled}) {
    return NotificationSate(
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
        openingNotificationEnabled:
            openingNotificationEnabled ?? this.openingNotificationEnabled,
        closingNotificationEnabled:
            closingNotificationEnabled ?? this.closingNotificationEnabled);
  }

  TimeOfDay durationToTimeOfDay(Duration duration) {
    return TimeOfDay(hour: duration.inHours, minute: duration.inMinutes % 60);
  }

  String durationToString(Duration duration) {
    if (duration.inMinutes % 60 == 0) {
      return '${duration.inHours.toString()}h';
    } else if (duration.inHours == 0) {
      return '${duration.inMinutes.toString()}mins';
    }
    return '${duration.inHours.toString()}h ${(duration.inMinutes % 60).toString()}mins';
  }
}
