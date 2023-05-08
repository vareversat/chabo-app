import 'dart:async';

import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_slot_event.dart';
part 'time_slot_state.dart';

class TimeSlotBloc extends Bloc<TimeSlotEvent, TimeSlotState> {
  final StorageService storageService;

  TimeSlotBloc({required this.storageService})
      : super(TimeSlotState(
          timeSlots: Const.notificationFavoriteSlotsDefaultValue,
          enabledForNotifications:
              Const.notificationFavoriteSlotsEnabledDefaultValue,
        )) {
    on<TimeSlotAppEvent>(
      _onAppEvent,
    );
    on<EnabledTimeSlotEvent>(
      _onEnabledTimeSlotEvent,
    );
    on<ValueTimeSlotEvent>(
      _onTimeSlotsEventValue,
    );
  }

  void _onAppEvent(
    TimeSlotAppEvent event,
    Emitter<TimeSlotState> emit,
  ) {
    final timeSlots =
        storageService.readTimeSlots(Const.notificationFavoriteSlotsValueKey) ??
            Const.notificationFavoriteSlotsDefaultValue;

    final enabledForNotifications =
        storageService.readBool(Const.notificationFavoriteSlotsEnabledKey) ??
            Const.notificationFavoriteSlotsEnabledDefaultValue;
    emit(state.copyWith(
      timeSlots: timeSlots,
      enabledForNotifications: enabledForNotifications,
    ));
  }

  Future<void> _onEnabledTimeSlotEvent(
    EnabledTimeSlotEvent event,
    Emitter<TimeSlotState> emit,
  ) async {
    await storageService.saveBool(
      Const.notificationFavoriteSlotsEnabledKey,
      event.enabled,
    );
    HapticFeedback.lightImpact();

    emit(state.copyWith(
      enabledForNotifications: event.enabled,
    ));
  }

  Future<void> _onTimeSlotsEventValue(
    ValueTimeSlotEvent event,
    Emitter<TimeSlotState> emit,
  ) async {
    final timeSlots = List<TimeSlot>.from(state.timeSlots);
    timeSlots[event.index] = event.timeSlot;
    await storageService.saveTimeSlots(
      Const.notificationFavoriteSlotsValueKey,
      timeSlots,
    );
    HapticFeedback.lightImpact();

    emit(
      state.copyWith(
        timeSlots: timeSlots,
      ),
    );
  }
}
