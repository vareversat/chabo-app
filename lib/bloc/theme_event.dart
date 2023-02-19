part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final ThemeStateStatus status;

  ThemeChanged({required this.status}) : super();
}
