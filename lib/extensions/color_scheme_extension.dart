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
}
