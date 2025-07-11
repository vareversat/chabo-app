import 'package:chabo_app/const.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeFormatCubit extends Cubit<TimeFormatState> {
  final StorageService storageService;

  TimeFormatCubit(this.storageService, super.initialState);

  void setTimeFormat() {
    final newDateFormat = state.timeFormat == TimeFormat.twentyFourHours
        ? TimeFormat.twelveHours
        : TimeFormat.twentyFourHours;
    storageService.saveTimeFormat(Const.timeFormatKey, newDateFormat);
    emit(state.copyWith(timeFormat: newDateFormat));
  }

  void init() {
    final timeFormat =
        storageService.readTimeFormat(Const.timeFormatKey) ??
        Const.timeFormatDefaultValue;
    emit(state.copyWith(timeFormat: timeFormat));
  }
}

class TimeFormatState extends Equatable {
  final TimeFormat timeFormat;

  const TimeFormatState({required this.timeFormat});

  TimeFormatState copyWith({TimeFormat? timeFormat}) {
    return TimeFormatState(timeFormat: timeFormat ?? this.timeFormat);
  }

  @override
  List<Object?> get props => [timeFormat];
}
