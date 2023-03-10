part of 'scroll_status_bloc.dart';

enum ScrollStatusStateType { automatic, manual }

class ScrollStatusEvent extends ChaboEvent {}

class ScrollStatusChanged extends ScrollStatusEvent {
  final ScrollStatusStateType type;

  ScrollStatusChanged({required this.type}) : super();
}
