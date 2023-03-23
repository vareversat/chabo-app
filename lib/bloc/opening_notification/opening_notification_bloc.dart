import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'opening_notification_event.dart';
part 'opening_notification_state.dart';

class OpeningNotificationBloc
    extends Bloc<OpeningNotificationEvent, OpeningNotificationState> {
  final StorageService storageService;

  OpeningNotificationBloc({required this.storageService})
      : super(OpeningNotificationState(enabled: false)) {
    on<OpeningAppStateChanged>(
      _onAppStateChanged,
    );
    on<OpeningNotificationChanged>(
      _onStateChanged,
    );
  }

  Future<void> _onStateChanged(event, emit) async {
    await storageService.saveBool(
        Const.notificationOpeningEnabledKey, event.enabled);
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(enabled: event.enabled),
    );
  }

  Future<void> _onAppStateChanged(event, emit) async {
    final enabledValue =
        storageService.readBool(Const.notificationOpeningEnabledKey) ??
            Const.notificationOpeningEnabledDefaultValue;
    emit(
      state.copyWith(enabled: enabledValue),
    );
  }
}
