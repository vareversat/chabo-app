import 'package:chabo_app/models/enums/day.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/models/time_slot.dart';
import 'package:chabo_app/models/web_link_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Const {
  /// App
  static const String appName = 'Chabo';
  static String legalLease = '© ${DateTime.now().year} - Valentin REVERSAT';

  /// List
  static const int forecastLimit = 1000;

  /// Image paths
  static const String appLogoPath = 'assets/images/chabo_icon.png';
  static const String chaboPhotoDayOpen =
      'assets/images/chaban_bridge_day_open.jpg';
  static const String chaboPhotoDayClosed =
      'assets/images/chaban_bridge_day_closed.jpg';
  static const String chaboPhotoNightOpen =
      'assets/images/chaban_bridge_night_open.jpg';
  static const String chaboPhotoNightClosed =
      'assets/images/chaban_bridge_night_closed.jpg';
  static const String oflLicensePath = 'assets/licenses/OFL.txt';

  // Credits
  static const String chaboPhotoDayOpenCredits =
      '© By Grand Parc - Bordeaux, France from France - Bordeaux. Pont Chaban Delmas sur la Garonne depuis rive droite - Photo Image Photography, CC BY 2.0';
  static const String chaboPhotoDayOpenCreditsLink =
      'https://commons.wikimedia.org/w/index.php?curid=37313921';
  static const String chaboPhotoNightOpenCredits =
      '© By Grand Parc - Bordeaux, France, CC BY 2.0';
  static const String chaboPhotoNightOpenCreditsLink =
      'https://commons.wikimedia.org/w/index.php?curid=27942907';

  static const String chaboPhotoDayClosedCredits =
      '© Bordeaux Stock photos by Vecteezy';
  static const String chaboPhotoDayClosedCreditsLink =
      'https://www.vecteezy.com/free-photos/bordeaux';
  static const String chaboPhotoNightClosedCredits =
      '© By Grand Parc - Bordeaux, France from France - Pont Chaban Delmas Bordeaux Gironde Garonne Nuit Night Photo Image Photography Picture, CC BY 2.0,';
  static const String chaboPhotoNightClosedCreditsLink =
      'https://commons.wikimedia.org/w/index.php?curid=37313786';

  /// Link
  static const String vesselFinderLinkPlaceholder = ':boatName:';
  static const String vesselFinderLink =
      'https://www.myshiptracking.com/vessels?side=false&name=$vesselFinderLinkPlaceholder';
  static const String githubLink = 'https://github.com/vareversat/chabo-app';
  static const String privacyInfoLink = 'https://chabo.vareversat.fr/privacy';
  static const String bordeauxWineFestivalSailingShipLink =
      'https://www.bordeaux-fete-le-vin.com/la-fete-sur-les-quais/grands-voiliers.html';
  static const String releaseUrl =
      'https://github.com/vareversat/chabo-app/releases/tag/v%';

  static List<WebLinkIcon> usefulLinks = [
    WebLinkIcon(
      'https://www.instagram.com/_yuhliet_/',
      FaIcon(FontAwesomeIcons.instagram, size: 20),
      'yuhliet_instagram',
    ),
    WebLinkIcon(
      'https://bordeaux-metropole.fr/',
      Icon(Icons.location_city_rounded, size: 20),
      'city_of_bordeaux',
    ),
    WebLinkIcon(
      'https://opendata.bordeaux-metropole.fr/',
      Icon(Icons.data_thresholding_rounded, size: 20),
      'bordeaux_open_data',
    ),
    WebLinkIcon(
      'https://github.com/vareversat/chabo-app',
      FaIcon(FontAwesomeIcons.github, size: 20),
      'source_code',
    ),
    WebLinkIcon(
      'https://chabo.vareversat.fr/%privacy',
      Icon(Icons.privacy_tip_rounded, size: 20),
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
  static const String timeFormatKey = 'TIME_FORMAT';

  /// Notifications
  static const String androidAppLogoPath =
      '@mipmap/ic_slice_launcher_adaptive_fore';
  static const Duration notificationDurationValueDefaultValue = Duration(
    minutes: 60,
  );
  static const bool notificationDurationEnabledDefaultValue = false;
  static TimeOfDay notificationTimeValueDefaultValue = const TimeOfDay(
    hour: 6,
    minute: 0,
  );
  static const bool notificationTimeEnabledDefaultValue = false;
  static const Day notificationDayValueDefaultValue = Day.sunday;
  static TimeOfDay notificationDayValueDefaultTimeValue = const TimeOfDay(
    hour: 20,
    minute: 00,
  );
  static const bool notificationDayEnabledDefaultValue = false;
  static const bool notificationOpeningEnabledDefaultValue = false;
  static const bool notificationClosingEnabledDefaultValue = false;
  static const bool notificationFavoriteSlotsEnabledDefaultValue = false;
  static List<TimeSlot> notificationFavoriteSlotsDefaultValue = [
    const TimeSlot(
      name: '',
      from: TimeOfDay(hour: 7, minute: 0),
      to: TimeOfDay(hour: 9, minute: 30),
    ),
    const TimeSlot(
      name: '',
      from: TimeOfDay(hour: 17, minute: 0),
      to: TimeOfDay(hour: 19, minute: 30),
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
  static const TimeFormat timeFormatDefaultValue = TimeFormat.twentyFourHours;

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
  static const String specialWineFestivalBoatsEvent = 'Bateaux fete du vin';
  static const String sentryDSNEnvKey = 'SENTRY_DSN';
  static const String envKey = 'ENV';
  static const String defaultEnv = 'dev';
  static const String multiBoatsEventSeparator = r' - ';
}
