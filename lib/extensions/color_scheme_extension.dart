import 'package:flutter/material.dart';

extension ColorSchemeExtension on ColorScheme {
  MaterialColor get warningColor {
    return brightness == Brightness.light ? Colors.orange : Colors.amber;
  }

  MaterialColor get timeColor {
    return brightness == Brightness.light ? Colors.orange : Colors.amber;
  }

  MaterialColor get boatColor {
    return brightness == Brightness.light ? Colors.blue : Colors.cyan;
  }

  MaterialColor get maintenanceColor {
    return brightness == Brightness.light ? Colors.brown : Colors.grey;
  }

  Color get okColor {
    return brightness == Brightness.dark
        ? const Color(0xFF81C784)
        : Colors.green;
  }

  Color get bordeauxColor {
    return brightness == Brightness.light
        ? const Color.fromRGBO(123, 31, 48, 1)
        : const Color.fromRGBO(167, 106, 117, 1);
  }

  Color get errorColor {
    return brightness == Brightness.light
        ? const Color(0xFFB00020)
        : const Color(0xFFCF6679);
  }
}
