import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scroll_status_event.dart';
part 'scroll_status_state.dart';

class ScrollStatusBloc extends Bloc<ScrollStatusEvent, ScrollStatusState> {
  final ScrollController scrollController;

  ScrollStatusBloc({required this.scrollController})
      : super(ScrollStatusState(
            showCurrentStatus: true, status: ScrollStatus.ok)) {
    on<ScrollStatusChanged>(
      _onScrollChanged,
      transformer: droppable(),
    );
    on<GoTo>(
      _goTo,
      transformer: sequential(),
    );
  }

  Future<void> _onScrollChanged(
      ScrollStatusChanged event, Emitter<ScrollStatusState> emit) async {
    emit(
      state.copyWith(
        showCurrentStatus: true,
        status: ScrollStatus.ok,
      ),
    );
  }

  Future<void> _goTo(GoTo event, Emitter<ScrollStatusState> emit) async {
    var targetContext = GlobalObjectKey(event.goTo.hashCode).currentContext;
    var offset = 0;
    while (targetContext == null) {
      var pixel = scrollController.position.pixels + offset >=
              scrollController.position.maxScrollExtent
          ? scrollController.position.pixels - offset
          : scrollController.position.pixels + offset;

      await scrollController.animateTo(pixel,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      targetContext = GlobalObjectKey(event.goTo.hashCode).currentContext;
      offset += 100;
      emit(
        state.copyWith(
          status: ScrollStatus.error,
        ),
      );
    }

    Scrollable.ensureVisible(targetContext,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    emit(
      state.copyWith(
        showCurrentStatus: false,
        status: ScrollStatus.ok,
      ),
    );
  }
}
