import 'package:chabo/bloc/chabo_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scroll_status_event.dart';

part 'scroll_status_state.dart';

class ScrollStatusBloc extends Bloc<ScrollStatusEvent, ScrollStatusState> {
  ScrollStatusBloc()
      : super(ScrollStatusState(isOnCurrentScheduleLevel: true)) {
    on<ScrollStatusChanged>(
      _onScrollChanged,
    );
  }

  Future<void> _onScrollChanged(
      ScrollStatusChanged event, Emitter<ScrollStatusState> emit) async {
    if (event.type == ScrollStatusStateType.automatic) {
      emit(
        state.copyWith(isOnCurrentScheduleLevel: false),
      );
    } else {
      emit(
        state.copyWith(isOnCurrentScheduleLevel: true),
      );
    }
  }
}
