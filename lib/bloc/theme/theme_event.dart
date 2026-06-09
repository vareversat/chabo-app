part of 'theme_bloc.dart';

class ThemeEvent extends ChaboEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeStateStatus status;

  ThemeChanged({required this.status}) : super();
}

class AppStateChanged extends ThemeEvent {
  AppStateChanged() : super();
}

class BridgeStateChanged extends ThemeEvent {
  final BridgeState bridgeState;

  BridgeStateChanged({required this.bridgeState}) : super();
}
