part of 'scroll_status_bloc.dart';

class ScrollStatusEvent extends ChaboEvent {}

class ScrollStatusChanged extends ScrollStatusEvent {
  ScrollStatusChanged() : super();
}

class GoTo extends ScrollStatusEvent {
  final AbstractForecast? goTo;

  GoTo({this.goTo}) : super();
}
