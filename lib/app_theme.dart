import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b608f),
      surfaceTint: Color(0xff3b608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd4e3ff),
      onPrimaryContainer: Color(0xff214876),
      secondary: Color(0xff8f4a4c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad9),
      onSecondaryContainer: Color(0xff733336),
      tertiary: Color(0xff8f4a4c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdad9),
      onTertiaryContainer: Color(0xff733336),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171c1e),
      onSurfaceVariant: Color(0xff43474e),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc3c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xffa5c8fe),
      primaryFixed: Color(0xffd4e3ff),
      onPrimaryFixed: Color(0xff001c3a),
      primaryFixedDim: Color(0xffa5c8fe),
      onPrimaryFixedVariant: Color(0xff214876),
      secondaryFixed: Color(0xffffdad9),
      onSecondaryFixed: Color(0xff3b080e),
      secondaryFixedDim: Color(0xffffb3b3),
      onSecondaryFixedVariant: Color(0xff733336),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff3b080e),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff733336),
      surfaceDim: Color(0xffd6dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff093764),
      surfaceTint: Color(0xff3b608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4b6f9f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5e2326),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa1585a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5e2326),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa1585a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff0c1214),
      onSurfaceVariant: Color(0xff32363d),
      outline: Color(0xff4f535a),
      outlineVariant: Color(0xff696d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xffa5c8fe),
      primaryFixed: Color(0xff4b6f9f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff315685),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa1585a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff844043),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffa1585a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff844043),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7ca),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffe4e9eb),
      surfaceContainerHigh: Color(0xffd8dee0),
      surfaceContainerHighest: Color(0xffcdd2d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002d56),
      surfaceTint: Color(0xff3b608f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff244a79),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff51191d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff763538),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff51191d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff763538),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282c33),
      outlineVariant: Color(0xff454951),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xffa5c8fe),
      primaryFixed: Color(0xff244a79),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff023361),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff763538),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff591f23),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff763538),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff591f23),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4babc),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf1f4),
      surfaceContainer: Color(0xffdee3e6),
      surfaceContainerHigh: Color(0xffd0d5d8),
      surfaceContainerHighest: Color(0xffc2c7ca),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa5c8fe),
      surfaceTint: Color(0xffa5c8fe),
      onPrimary: Color(0xff00315e),
      primaryContainer: Color(0xff214876),
      onPrimaryContainer: Color(0xffd4e3ff),
      secondary: Color(0xffffb3b3),
      onSecondary: Color(0xff561d21),
      secondaryContainer: Color(0xff733336),
      onSecondaryContainer: Color(0xffffdad9),
      tertiary: Color(0xffffb3b3),
      onTertiary: Color(0xff561d21),
      tertiaryContainer: Color(0xff733336),
      onTertiaryContainer: Color(0xffffdad9),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e6),
      onSurfaceVariant: Color(0xffc3c6cf),
      outline: Color(0xff8d9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff3b608f),
      primaryFixed: Color(0xffd4e3ff),
      onPrimaryFixed: Color(0xff001c3a),
      primaryFixedDim: Color(0xffa5c8fe),
      onPrimaryFixedVariant: Color(0xff214876),
      secondaryFixed: Color(0xffffdad9),
      onSecondaryFixed: Color(0xff3b080e),
      secondaryFixedDim: Color(0xffffb3b3),
      onSecondaryFixedVariant: Color(0xff733336),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff3b080e),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff733336),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2022),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcaddff),
      surfaceTint: Color(0xffa5c8fe),
      onPrimary: Color(0xff00264b),
      primaryContainer: Color(0xff6f92c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd1d1),
      onSecondary: Color(0xff481217),
      secondaryContainer: Color(0xffcb7a7c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd1d1),
      onTertiary: Color(0xff481217),
      tertiaryContainer: Color(0xffcb7a7c),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9dce5),
      outline: Color(0xffafb2bb),
      outlineVariant: Color(0xff8d9099),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff224977),
      primaryFixed: Color(0xffd4e3ff),
      onPrimaryFixed: Color(0xff001128),
      primaryFixedDim: Color(0xffa5c8fe),
      onPrimaryFixedVariant: Color(0xff093764),
      secondaryFixed: Color(0xffffdad9),
      onSecondaryFixed: Color(0xff2c0105),
      secondaryFixedDim: Color(0xffffb3b3),
      onSecondaryFixedVariant: Color(0xff5e2326),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff2c0105),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff5e2326),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff404547),
      surfaceContainerLowest: Color(0xff04080a),
      surfaceContainerLow: Color(0xff191e20),
      surfaceContainer: Color(0xff23292b),
      surfaceContainerHigh: Color(0xff2e3335),
      surfaceContainerHighest: Color(0xff393f41),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeaf0ff),
      surfaceTint: Color(0xffa5c8fe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa1c5fa),
      onPrimaryContainer: Color(0xff000b1d),
      secondary: Color(0xffffeceb),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffadae),
      onSecondaryContainer: Color(0xff220003),
      tertiary: Color(0xffffeceb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffadae),
      onTertiaryContainer: Color(0xff220003),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf0f9),
      outlineVariant: Color(0xffbfc2cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff224977),
      primaryFixed: Color(0xffd4e3ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa5c8fe),
      onPrimaryFixedVariant: Color(0xff001128),
      secondaryFixed: Color(0xffffdad9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb3b3),
      onSecondaryFixedVariant: Color(0xff2c0105),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff2c0105),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff4b5153),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2022),
      surfaceContainer: Color(0xff2c3133),
      surfaceContainerHigh: Color(0xff373c3e),
      surfaceContainerHighest: Color(0xff42484a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
