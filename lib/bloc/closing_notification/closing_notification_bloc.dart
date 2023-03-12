import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'closing_notification_event.dart';

part 'closing_notification_state.dart';

class ClosingNotificationBloc
    extends Bloc<ClosingNotificationEvent, ClosingNotificationState> {
  final StorageService storageService;

  ClosingNotificationBloc({required this.storageService})
      : super(ClosingNotificationState(enabled: false)) {
    on<ClosingAppStateChanged>(
      _onAppStateChanged,
    );
    on<ClosingNotificationChanged>(
      _onStateChanged,
    );
  }

  Future<void> _onStateChanged(event, emit) async {
    await storageService.saveBool(
        Const.notificationClosingEnabledKey, event.enabled);
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }

  Future<void> _onAppStateChanged(event, emit) async {
    final enabledValue =
        storageService.readBool(Const.notificationClosingEnabledKey) ??
            Const.notificationClosingEnabledDefaultValue;
    emit(
      state.copyWith(enabled: enabledValue),
    );
  }
}
