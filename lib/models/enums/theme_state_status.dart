import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum ThemeStateStatus { light, dark, system }

extension ThemeStateStatusExtension on ThemeStateStatus? {
  IconData get icon {
    switch (this) {
      case ThemeStateStatus.light:
        return Icons.brightness_5_rounded;
      case ThemeStateStatus.dark:
        return Icons.dark_mode_rounded;
      case ThemeStateStatus.system:
        return Icons.devices_rounded;
      default:
        return Icons.error;
    }
  }

  String text(BuildContext context) {
    switch (this) {
      case ThemeStateStatus.light:
        return AppLocalizations.of(context)!.lightTheme;
      case ThemeStateStatus.dark:
        return AppLocalizations.of(context)!.darkTheme;
      case ThemeStateStatus.system:
        return AppLocalizations.of(context)!.systemTheme;
      default:
        return 'no_value';
    }
  }
}
