import 'package:chabo_app/const.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionsCubit extends Cubit<FloatingActionsState> {
  final StorageService storageService;

  FloatingActionsCubit(this.storageService, super.initialState);

  void openFloatingActions() {
    emit(state.copyWith(isMenuOpen: !state.isMenuOpen));
  }

  void changeFloatingActionsSide() {
    storageService.saveBool(Const.isRightHandedKey, !state.isRightHanded);
    emit(state.copyWith(isRightHanded: !state.isRightHanded));
  }

  void init() {
    final isRightHanded =
        storageService.readBool(Const.isRightHandedKey) ??
        Const.isRightHandedDefaultValue;
    emit(state.copyWith(isRightHanded: isRightHanded));
  }
}

class FloatingActionsState extends Equatable {
  final bool isMenuOpen;
  final bool isRightHanded;

  const FloatingActionsState({
    required this.isMenuOpen,
    required this.isRightHanded,
  });

  FloatingActionsState copyWith({bool? isMenuOpen, bool? isRightHanded}) {
    return FloatingActionsState(
      isMenuOpen: isMenuOpen ?? this.isMenuOpen,
      isRightHanded: isRightHanded ?? this.isRightHanded,
    );
  }

  @override
  List<Object?> get props => [isMenuOpen, isRightHanded];
}
