import 'package:chabo/models/enums/day.dart';

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
  static const String androidAppLogoPath =
      '@mipmap/ic_slice_launcher_adaptive_fore';
  static const Duration notificationDurationValueDefaultValue =
      Duration(minutes: 60);
  static const bool notificationDurationEnabledDefaultValue = true;
  static const Duration notificationTimeValueDefaultValue =
      Duration(hours: 20, minutes: 00);
  static const bool notificationTimeEnabledDefaultValue = false;
  static const Day notificationDayValueDefaultValue = Day.sunday;
  static const bool notificationDayEnabledDefaultValue = false;

  /// Android Notifications
  static const String androidTicket = 'ticker';
  static const String notificationDurationChannelId = 'imminent_closures';
  static const String notificationTimeChannelId = 'tomorrow_closures';

  /// Notification misc
  static const int durationNotificationStartId = 0;
  static const int timeNotificationStartId = 1000;
  static const int dayNotificationStartId = 2000;

  /// AdMod
  static const String androidInlineBanner =
      'ca-app-pub-4365376442391282/2675286687';
}
