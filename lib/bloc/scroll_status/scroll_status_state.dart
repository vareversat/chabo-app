part of 'scroll_status_bloc.dart';

class ScrollStatusState {
  final AbstractForecast? currentTarget;
  final bool showCurrentStatus;
  final ScrollStatus status;

  ScrollStatusState({
    required this.status,
    required this.showCurrentStatus,
    required this.currentTarget,
  });

  ScrollStatusState copyWith({
    bool? showCurrentStatus,
    ScrollStatus? status,
    AbstractForecast? currentTarget,
  }) {
    return ScrollStatusState(
      status: status ?? this.status,
      showCurrentStatus: showCurrentStatus ?? this.showCurrentStatus,
      currentTarget: currentTarget ?? this.currentTarget,
    );
  }
}

enum ScrollStatus { ok, error }
