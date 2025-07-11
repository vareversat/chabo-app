import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: GoogleFonts.josefinSansTextTheme(ThemeData.light().textTheme),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    textTheme: GoogleFonts.josefinSansTextTheme(ThemeData.dark().textTheme),
  );
}
