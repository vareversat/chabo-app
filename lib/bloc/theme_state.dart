part of 'theme_bloc.dart';

enum ThemeStateStatus { bright, dark, system }

class ThemeState {
  final ThemeStateStatus status;
  final ThemeData themeData;

  ThemeState({required this.themeData, this.status = ThemeStateStatus.bright});

  ThemeState copyWith({ThemeStateStatus? status, ThemeData? themeData}) {
    return ThemeState(
        status: status ?? this.status, themeData: themeData ?? this.themeData);
  }

  IconData getIconData() {
    if (themeData == AppThemes.brightTheme) {
      return Icons.brightness_low;
    } else {
      return Icons.dark_mode_outlined;
    }
  }
}
