import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final StorageService storageService;

  NotificationBloc({required this.storageService})
      : super(
          NotificationState(
            durationNotificationEnabled:
                Const.notificationDurationEnabledDefaultValue,
            durationNotificationValue:
                Const.notificationDurationValueDefaultValue,
            timeNotificationEnabled: Const.notificationTimeEnabledDefaultValue,
            timeNotificationValue: Const.notificationTimeValueDefaultValue,
            dayNotificationEnabled: Const.notificationDayEnabledDefaultValue,
            dayNotificationValue: Const.notificationDayValueDefaultValue,
            dayNotificationTimeValue:
                Const.notificationDayValueDefaultTimeValue,
            openingNotificationEnabled:
                Const.notificationOpeningEnabledDefaultValue,
            closingNotificationEnabled:
                Const.notificationClosingEnabledDefaultValue,
          ),
        ) {
    on<OpeningNotificationStateEvent>(
      _onOpeningNotificationStateEvent,
    );
    on<ClosingNotificationStateEvent>(
      _onClosingNotificationStateEvent,
    );
    on<DayNotificationStateEvent>(
      _onDayNotificationStateEvent,
    );
    on<DayNotificationValueEvent>(
      _onDayNotificationValueEvent,
    );
    on<DayNotificationTimeValueEvent>(
      _onDayNotificationTimeValueEvent,
    );
    on<TimeNotificationStateEvent>(
      _onTimeNotificationStateEvent,
    );
    on<TimeNotificationValueEvent>(
      _onTimeNotificationValueEvent,
    );
    on<DurationNotificationStateEvent>(
      _onDurationNotificationStateEvent,
    );
    on<DurationNotificationValueEvent>(
      _onDurationNotificationValueEvent,
    );
    on<AppEvent>(
      _onAppEvent,
    );
  }

  Future<void> _onOpeningNotificationStateEvent(
    OpeningNotificationStateEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveBool(
      Const.notificationOpeningEnabledKey,
      event.enabled,
    );
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(openingNotificationEnabled: event.enabled),
    );
  }

  Future<void> _onClosingNotificationStateEvent(
    ClosingNotificationStateEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveBool(
      Const.notificationClosingEnabledKey,
      event.enabled,
    );
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(closingNotificationEnabled: event.enabled),
    );
  }

  Future<void> _onDayNotificationStateEvent(
    DayNotificationStateEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveBool(
      Const.notificationDayEnabledKey,
      event.enabled,
    );
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(dayNotificationEnabled: event.enabled),
    );
  }

  Future<void> _onDayNotificationValueEvent(
    DayNotificationValueEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveDay(Const.notificationDayValueKey, event.day);
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(dayNotificationValue: event.day),
    );
  }

  Future<void> _onDayNotificationTimeValueEvent(
    DayNotificationTimeValueEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveTimeOfDay(
      Const.notificationDayTimeValueKey,
      event.time,
    );
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(dayNotificationTimeValue: event.time),
    );
  }

  Future<void> _onTimeNotificationStateEvent(
    TimeNotificationStateEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveBool(
      Const.notificationTimeEnabledKey,
      event.enabled,
    );
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(timeNotificationEnabled: event.enabled),
    );
  }

  Future<void> _onTimeNotificationValueEvent(
    TimeNotificationValueEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveTimeOfDay(
      Const.notificationTimeValueKey,
      event.time,
    );
    emit(
      state.copyWith(timeNotificationValue: event.time),
    );
  }

  Future<void> _onDurationNotificationStateEvent(
    DurationNotificationStateEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveBool(
      Const.notificationDurationEnabledKey,
      event.enabled,
    );
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(
        durationNotificationEnabled: event.enabled,
      ),
    );
  }

  Future<void> _onDurationNotificationValueEvent(
    DurationNotificationValueEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await storageService.saveDuration(
      Const.notificationDurationValueKey,
      event.duration,
    );
    emit(
      state.copyWith(durationNotificationValue: event.duration),
    );
  }

  void _onAppEvent(
    AppEvent event,
    Emitter<NotificationState> emit,
  ) {
    final durationNotificationEnabled =
        storageService.readBool(Const.notificationDurationEnabledKey) ??
            Const.notificationDurationEnabledDefaultValue;

    final durationNotificationValue =
        storageService.readDuration(Const.notificationDurationValueKey) ??
            Const.notificationDurationValueDefaultValue;

    final timeNotificationEnabled =
        storageService.readBool(Const.notificationTimeEnabledKey) ??
            Const.notificationTimeEnabledDefaultValue;

    final timeNotificationValue =
        storageService.readTimeOfDay(Const.notificationTimeValueKey) ??
            Const.notificationTimeValueDefaultValue;

    final dayNotificationEnabled =
        storageService.readBool(Const.notificationDayEnabledKey) ??
            Const.notificationDayEnabledDefaultValue;

    final dayNotificationValue =
        storageService.readDay(Const.notificationDayValueKey) ??
            Const.notificationDayValueDefaultValue;

    final dayNotificationTimeValue =
        storageService.readTimeOfDay(Const.notificationDayTimeValueKey) ??
            Const.notificationDayValueDefaultTimeValue;

    final openingNotificationEnabled =
        storageService.readBool(Const.notificationOpeningEnabledKey) ??
            Const.notificationOpeningEnabledDefaultValue;

    final closingNotificationEnabled =
        storageService.readBool(Const.notificationClosingEnabledKey) ??
            Const.notificationClosingEnabledDefaultValue;

    emit(
      state.copyWith(
        durationNotificationEnabled: durationNotificationEnabled,
        durationNotificationValue: durationNotificationValue,
        timeNotificationEnabled: timeNotificationEnabled,
        timeNotificationValue: timeNotificationValue,
        dayNotificationEnabled: dayNotificationEnabled,
        dayNotificationValue: dayNotificationValue,
        dayNotificationTimeValue: dayNotificationTimeValue,
        openingNotificationEnabled: openingNotificationEnabled,
        closingNotificationEnabled: closingNotificationEnabled,
      ),
    );
  }
}
