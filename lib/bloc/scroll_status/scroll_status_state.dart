part of 'scroll_status_bloc.dart';

class ScrollStatusState extends Equatable {
  final AbstractForecast? currentTarget;
  final bool showCurrentStatus;
  final ScrollStatus status;

  const ScrollStatusState({
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

  @override
  List<Object?> get props => [currentTarget, showCurrentStatus, status];
}

enum ScrollStatus { ok, error }
