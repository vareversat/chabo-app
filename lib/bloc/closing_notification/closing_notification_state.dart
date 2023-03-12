part of 'closing_notification_bloc.dart';

class ClosingNotificationState {
  final bool enabled;

  ClosingNotificationState({required this.enabled});

  ClosingNotificationState copyWith({bool? enabled}) {
    return ClosingNotificationState(enabled: enabled ?? this.enabled);
  }
}
