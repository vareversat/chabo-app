import 'package:chabo/models/link_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Const {
  /// App
  static const String appName = 'Chabo';
  static String legalLease = '© ${DateTime.now().year} - Valentin REVERSAT';

  /// Paths
  static const String changelogPlaceholder = ':lang:';
  static const String changelogPath = 'CHANGELOG_$changelogPlaceholder.md';
  static const String appLogoPath = 'assets/images/chabo_icon.png';

  /// Link
  static const String vesselFinderLinkPlaceholder = ':boatName:';
  static const String vesselFinderLink =
      'https://www.vesselfinder.com/fr/vessels?name=$vesselFinderLinkPlaceholder&type=301';
  static const String githubLink = 'https://github.com/vareversat/chabo';
  static const String privacyInfoLink = 'https://chabo.vareversat.fr/privacy';

  static List<WebLinkIcon> usefulLinks = [
    WebLinkIcon('https://www.instagram.com/_yuhliet_/',
        FontAwesomeIcons.instagram, 'yuhliet_instagram'),
    WebLinkIcon('https://bordeaux-metropole.fr/', Icons.location_city_rounded,
        'city_of_bordeaux'),
    WebLinkIcon('https://opendata.bordeaux-metropole.fr/',
        Icons.data_thresholding_rounded, 'bordeaux_open_data'),
    WebLinkIcon('https://github.com/vareversat/chabo', FontAwesomeIcons.github,
        'source_code'),
    WebLinkIcon('https://chabo.vareversat.fr/privacy',
        Icons.privacy_tip_rounded, 'privacy_policy'),
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
  static const String notificationOpeningEnabledKey =
      'NOTIFICATION_OPENING_SETTINGS_ENABLED';
  static const String notificationClosingEnabledKey =
      'NOTIFICATION_CLOSING_SETTINGS_ENABLED';

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
  static const bool notificationOpeningEnabledDefaultValue = false;
  static const bool notificationClosingEnabledDefaultValue = false;

  /// Android Notifications
  static const String androidTicket = 'ticker';
  static const String notificationDurationChannelId = 'imminent_closures';
  static const String notificationTimeChannelId = 'tomorrow_closures';
  static const String notificationOpeningChannelId = 'opening';
  static const String notificationClosingChannelId = 'closing';
  static const String notificationDayChannelId = 'next_week_closures';

  /// AdMod
  static const String androidInlineBanner =
      'ca-app-pub-4365376442391282/2675286687';
  static const String androidNativeBanner =
      'ca-app-pub-4365376442391282/5786413607';
}
