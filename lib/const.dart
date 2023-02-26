import 'package:chabo/models/enums/day.dart';
import 'package:flutter/material.dart';

class Const {
  /// App
  static const String appName = 'Chabo';

  /// Paths
  static const String changelogPath = 'CHANGELOG.md';
  static const String appLogoPath = 'assets/images/chabo_icon.png';

  /// Link
  static const String githubLink = 'https://github.com/vareversat/chabo';
  static const String privacyInfoLink = 'https://chabo.vareversat.fr/privacy';
  static const List<String> usefulLinks = [
    'https://www.instagram.com/_yuhliet_/',
    'https://sedeplacer.bordeaux-metropole.fr/',
    'https://opendata.bordeaux-metropole.fr/'
  ];

  /// Local storage
  static const String storageThemeKey = 'THEME';
  static const String notificationDurationEnabledKey =
      'NOTIFICATION_DURATION_SETTINGS_ENABLED';
  static const String notificationDurationValueKey =
      'NOTIFICATION_DURATION_SETTINGS_VALUE';
  static const String notificationTimeEnabledKey =
      'NOTIFICATION_TIME_SETTINGS_ENABLED';
  static const String notificationTimeValueKey =
      'NOTIFICATION_TIME_SETTINGS_VALUE';
  static const String notificationDayEnabledKey =
      'NOTIFICATION_DAY_SETTINGS_ENABLED';
  static const String notificationDayValueKey =
      'NOTIFICATION_DAY_SETTINGS_VALUE';

  /// Notifications
  static const String androidAppLogoPath = '@drawable/ic_launcher_foreground';
  static const Duration notificationDurationValueDefaultValue =
      Duration(minutes: 60);
  static const bool notificationDurationEnabledDefaultValue = true;
  static const TimeOfDay notificationTimeValueDefaultValue =
      TimeOfDay(hour: 20, minute: 00);
  static const bool notificationTimeEnabledDefaultValue = false;
  static const Day notificationDayValueDefaultValue = Day.sunday;
  static const bool notificationDayEnabledDefaultValue = false;
}
