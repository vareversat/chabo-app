import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionsCubit extends Cubit<bool> {
  FloatingActionsCubit(super.initialState);

  void openActions() {
    emit(!state);
  }
}
