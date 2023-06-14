import 'package:chabo/models/enums/day.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:chabo/models/web_link_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Const {
  /// App
  static const String appName = 'Chabo';
  static String legalLease = '© ${DateTime.now().year} - Valentin REVERSAT';

  /// List
  static const int forecastLimit = 1000;

  /// Paths
  static const String changelogPlaceholder = ':lang:';
  static const String changelogPath =
      'changelogs/CHANGELOG_$changelogPlaceholder.md';
  static const String appLogoPath = 'assets/images/chabo_icon.png';
  static const String oflLicensePath = 'assets/licenses/OFL.txt';

  /// Link
  static const String vesselFinderLinkPlaceholder = ':boatName:';
  static const String vesselFinderLink =
      'https://www.vesselfinder.com/fr/vessels?name=$vesselFinderLinkPlaceholder&type=301';
  static const String githubLink = 'https://github.com/vareversat/chabo';
  static const String privacyInfoLink = 'https://chabo.vareversat.fr/privacy';

  static List<WebLinkIcon> usefulLinks = [
    WebLinkIcon(
      'https://www.instagram.com/_yuhliet_/',
      FontAwesomeIcons.instagram,
      'yuhliet_instagram',
    ),
    WebLinkIcon(
      'https://bordeaux-metropole.fr/',
      Icons.location_city_rounded,
      'city_of_bordeaux',
    ),
    WebLinkIcon(
      'https://opendata.bordeaux-metropole.fr/',
      Icons.data_thresholding_rounded,
      'bordeaux_open_data',
    ),
    WebLinkIcon(
      'https://github.com/vareversat/chabo',
      FontAwesomeIcons.github,
      'source_code',
    ),
    WebLinkIcon(
      'https://chabo.vareversat.fr/privacy',
      Icons.privacy_tip_rounded,
      'privacy_policy',
    ),
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
  static const String notificationDayTimeValueKey =
      'NOTIFICATION_DAY_TIME_SETTINGS_VALUE';
  static const String notificationOpeningEnabledKey =
      'NOTIFICATION_OPENING_SETTINGS_ENABLED';
  static const String notificationClosingEnabledKey =
      'NOTIFICATION_CLOSING_SETTINGS_ENABLED';
  static const String isRightHandedKey = 'RIGHT_HANDED';
  static const String notificationFavoriteSlotsEnabledKey =
      'NOTIFICATION_FAVORITE_SLOTS_SETTINGS_ENABLED';
  static const String notificationFavoriteSlotsValueKey =
      'NOTIFICATION_FAVORITE_SLOTS_SETTINGS_VALUE';
  static const String notificationFavoriteSlotsDaysValueKey =
      'NOTIFICATION_FAVORITE_SLOTS_DAYS_SETTINGS_VALUE';

  /// Notifications
  static const String androidAppLogoPath =
      '@mipmap/ic_slice_launcher_adaptive_fore';
  static const Duration notificationDurationValueDefaultValue =
      Duration(minutes: 60);
  static const bool notificationDurationEnabledDefaultValue = false;
  static TimeOfDay notificationTimeValueDefaultValue =
      const TimeOfDay(hour: 6, minute: 0);
  static const bool notificationTimeEnabledDefaultValue = false;
  static const Day notificationDayValueDefaultValue = Day.sunday;
  static TimeOfDay notificationDayValueDefaultTimeValue =
      const TimeOfDay(hour: 20, minute: 00);
  static const bool notificationDayEnabledDefaultValue = false;
  static const bool notificationOpeningEnabledDefaultValue = false;
  static const bool notificationClosingEnabledDefaultValue = false;
  static const bool notificationFavoriteSlotsEnabledDefaultValue = false;
  static List<TimeSlot> notificationFavoriteSlotsDefaultValue = [
    const TimeSlot(
      name: '',
      from: TimeOfDay(hour: 7, minute: 0),
      to: TimeOfDay(
        hour: 9,
        minute: 30,
      ),
    ),
    const TimeSlot(
      name: '',
      from: TimeOfDay(hour: 17, minute: 0),
      to: TimeOfDay(
        hour: 19,
        minute: 30,
      ),
    ),
  ];
  static List<Day> notificationFavoriteSlotsDaysDefaultValue = [
    Day.monday,
    Day.tuesday,
    Day.wednesday,
    Day.thursday,
    Day.friday,
  ];

  /// UI
  static const bool isRightHandedDefaultValue = true;

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

  /// Misc
  static const List<String> vowelList = ['a', 'e', 'i', 'o', 'u', 'y'];
  static const String oflLicenseEntryName = 'google_fonts';
}
