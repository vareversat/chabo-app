part of 'opening_notification_bloc.dart';

class OpeningNotificationState {
  final bool enabled;

  OpeningNotificationState({required this.enabled});

  OpeningNotificationState copyWith({bool? enabled}) {
    return OpeningNotificationState(enabled: enabled ?? this.enabled);
  }
}
