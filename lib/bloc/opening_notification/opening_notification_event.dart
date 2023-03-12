part of 'opening_notification_bloc.dart';

class OpeningNotificationEvent extends ChaboEvent {}

class OpeningNotificationChanged extends OpeningNotificationEvent {
  final bool enabled;

  OpeningNotificationChanged({required this.enabled}) : super();
}

class OpeningAppStateChanged extends OpeningNotificationEvent {
  OpeningAppStateChanged() : super();
}
