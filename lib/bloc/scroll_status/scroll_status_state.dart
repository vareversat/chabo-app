part of 'scroll_status_bloc.dart';

class ScrollStatusState {
  bool isOnCurrentScheduleLevel;

  ScrollStatusState({required this.isOnCurrentScheduleLevel});

  ScrollStatusState copyWith({bool? isOnCurrentScheduleLevel}) {
    return ScrollStatusState(
        isOnCurrentScheduleLevel:
            isOnCurrentScheduleLevel ?? this.isOnCurrentScheduleLevel);
  }
}
