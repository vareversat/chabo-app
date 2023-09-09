part of 'theme_bloc.dart';

class ThemeState {
  final ThemeStateStatus status;
  final ThemeData themeData;

  ThemeState({required this.themeData, this.status = ThemeStateStatus.light});

  ThemeState copyWith({ThemeStateStatus? status, ThemeData? themeData}) {
    return ThemeState(
      status: status ?? this.status,
      themeData: themeData ?? this.themeData,
    );
  }
}
