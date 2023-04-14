part of 'scroll_status_bloc.dart';

enum ScrollStatus { ok, error }

class ScrollStatusState {
  final AbstractChabanBridgeForecast? currentTarget;
  final bool showCurrentStatus;
  final ScrollStatus status;

  ScrollStatusState(
      {required this.status,
      required this.showCurrentStatus,
      required this.currentTarget});

  ScrollStatusState copyWith(
      {bool? showCurrentStatus,
      ScrollStatus? status,
      AbstractChabanBridgeForecast? currentTarget}) {
    return ScrollStatusState(
        status: status ?? this.status,
        showCurrentStatus: showCurrentStatus ?? this.showCurrentStatus,
        currentTarget: currentTarget ?? this.currentTarget);
  }
}
