part of 'scroll_status_bloc.dart';

enum ScrollStatus { ok, error }

class ScrollStatusState {
  final bool showCurrentStatus;
  final ScrollStatus status;

  ScrollStatusState({required this.status, required this.showCurrentStatus});

  ScrollStatusState copyWith({bool? showCurrentStatus, ScrollStatus? status}) {
    return ScrollStatusState(
        status: status ?? this.status,
        showCurrentStatus: showCurrentStatus ?? this.showCurrentStatus);
  }
}
