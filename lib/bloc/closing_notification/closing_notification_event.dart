part of 'closing_notification_bloc.dart';

class ClosingNotificationEvent extends ChaboEvent {}

class ClosingNotificationChanged extends ClosingNotificationEvent {
  final bool enabled;

  ClosingNotificationChanged({required this.enabled}) : super();
}

class ClosingAppStateChanged extends ClosingNotificationEvent {
  ClosingAppStateChanged() : super();
}
