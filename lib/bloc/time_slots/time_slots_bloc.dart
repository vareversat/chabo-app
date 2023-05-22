import 'package:chabo/bloc/chabo_event.dart';
import 'package:chabo/const.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_slots_event.dart';
part 'time_slots_state.dart';

class TimeSlotsBloc extends Bloc<TimeSlotsEvent, TimeSlotsState> {
  final StorageService storageService;

  TimeSlotsBloc({required this.storageService}) : super(TimeSlotsInitial()) {
    on<TimeSlotChanged>(
      _onTimeSlotChanged,
    );

    on<DaysChanged>(
      _onDaysChanged,
    );

    on<TimeSlotsAppEvent>(
      _onAppEvent,
    );
  }

  Future<void> _onTimeSlotChanged(
    TimeSlotChanged event,
    Emitter<TimeSlotsState> emit,
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

  Future<void> _onDaysChanged(
    DaysChanged event,
    Emitter<TimeSlotsState> emit,
  ) async {
    final days = List<Day>.from(state.days);
    if (event.isSelected) {
      days.add(event.day);
    } else {
      days.remove(event.day);
    }

    await storageService.saveDays(
      Const.notificationFavoriteSlotsDaysValueKey,
      days,
    );
    HapticFeedback.lightImpact();

    emit(
      state.copyWith(
        days: days,
      ),
    );
  }

  void _onAppEvent(
    TimeSlotsAppEvent event,
    Emitter<TimeSlotsState> emit,
  ) {
    final days =
        storageService.readDays(Const.notificationFavoriteSlotsDaysValueKey) ??
            Const.notificationFavoriteSlotsDaysDefaultValue;

    final timeSlots =
        storageService.readTimeSlots(Const.notificationFavoriteSlotsValueKey) ??
            Const.notificationFavoriteSlotsDefaultValue;

    emit(
      state.copyWith(
        days: days,
        timeSlots: timeSlots,
      ),
    );
  }
}
