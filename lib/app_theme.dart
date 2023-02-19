import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final brightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    useMaterial3: true,
    textTheme: GoogleFonts.josefinSansTextTheme(),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff6200ee),
        onPrimary: Colors.white,
        secondary: Color(0xff03dac6),
        onSecondary: Colors.black,
        error: Color(0xffb00020),
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black45,
    primarySwatch: Colors.teal,
    useMaterial3: true,
    textTheme: GoogleFonts.josefinSansTextTheme(),
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffbb86fc),
        onPrimary: Colors.black,
        secondary: Color(0xff03dac6),
        onSecondary: Colors.black,
        error: Color(0xffcf6679),
        onError: Colors.white,
        background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white),
  );
}
