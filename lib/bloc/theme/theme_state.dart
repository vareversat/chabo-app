part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeStateStatus status;
  final ThemeData themeData;
  final String imagePath;
  final String imageCredits;
  final String imageCreditsLink;
  final BridgeState bridgeState;

  const ThemeState({
    required this.themeData,
    required this.imagePath,
    required this.imageCredits,
    required this.imageCreditsLink,
    this.status = ThemeStateStatus.light,
    required this.bridgeState,
  });

  ThemeState copyWith({
    ThemeStateStatus? status,
    String? imagePath,
    String? imageCredits,
    String? imageCreditsLink,
    ThemeData? themeData,
    BridgeState? bridgeState,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeData: themeData ?? this.themeData,
      imagePath: imagePath ?? this.imagePath,
      imageCredits: imageCredits ?? this.imageCredits,
      imageCreditsLink: imageCreditsLink ?? this.imageCreditsLink,
      bridgeState: bridgeState ?? this.bridgeState,
    );
  }

  @override
  List<Object?> get props => [
    status,
    themeData,
    imagePath,
    imageCredits,
    imageCreditsLink,
    bridgeState,
  ];
}
