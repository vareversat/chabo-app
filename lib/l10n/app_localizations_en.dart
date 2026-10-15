// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get and => 'and';

  @override
  String get credits => 'Credits';

  @override
  String the(String startWithVowel) {
    String _temp0 = intl.Intl.selectLogic(
      startWithVowel,
      {
        'true': 'the ',
        'other': 'the ',
      },
    );
    return '$_temp0';
  }

  @override
  String get circulationClosing => 'closing';

  @override
  String get circulationReOpening => 're opening';

  @override
  String get isClosed => 'closed';

  @override
  String get daySmall => 'd';

  @override
  String get goodAfternoon => 'good afternoon';

  @override
  String get goodEvening => 'good evening';

  @override
  String get goodMorning => 'good morning';

  @override
  String get nextClosingScheduled => 'next closing scheduled in';

  @override
  String get isOpen => 'open';

  @override
  String get scheduledToOpen => 'scheduled to open in';

  @override
  String get theChabanBridgeIsOpen => 'the Chaban bridge is open to traffic';

  @override
  String get theChabanBridgeIsClosed =>
      'the Chaban bridge is closed to traffic';

  @override
  String get theChabanBridgeWillSoonClose =>
      'the Chaban bridge will soon close to traffic';

  @override
  String get willSoonClose => 'close soon';

  @override
  String get dialogInformationContentThe => '';

  @override
  String get dialogInformationContentThe2 => 'from ';

  @override
  String get dialogInformationContentFromStart => 'from';

  @override
  String get dialogInformationContentFromEnd => 'to';

  @override
  String get dialogInformationContentFromEnd2 => 'to';

  @override
  String get dialogInformationContentBridge_closed =>
      'the Chaban bridge will be closed for';

  @override
  String dialogInformationContentBridgeDeparture(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'the',
      one: 'the',
    );
    return 'the departure of the $_temp0';
  }

  @override
  String dialogInformationContentBridgeArrival(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'the',
      one: 'the',
    );
    return 'the arrival of $_temp0';
  }

  @override
  String get duration => 'Duration';

  @override
  String get errorScreenContentError => 'Error';

  @override
  String get errorScreenContentMessage =>
      'An error occurred while opening this page. Please find technical information below';

  @override
  String get errorScreenContentTechnical_Info => 'Technical information';

  @override
  String get unableAppInfo => 'Unable to get application information';

  @override
  String get appDescription =>
      'The Mobile app to get the closing and opening schedules of the Chaban Delmas bridge located in Bordeaux, France';

  @override
  String get disclaimer =>
      'Disclaimer: provisional closures. Subject to confirmation from the Harbor Master\'s Office.';

  @override
  String get openSetting => 'Settings';

  @override
  String get themeSettingTitle => 'Theme';

  @override
  String get themeSettingSubTitle => 'Change the appearance of the application';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get schedules => 'Schedules';

  @override
  String get systemTheme => 'System theme';

  @override
  String get notifications => 'Notifications';

  @override
  String durationNotificationTitle(Object duration) {
    return '${duration}before';
  }

  @override
  String durationNotificationExplanation(Object duration) {
    return 'Receive a notification ${duration}before the next closing. This value also manages the color change of the current status';
  }

  @override
  String timeNotificationTitle(Object time) {
    return 'The day before at $time';
  }

  @override
  String timeNotificationExplanation(Object time) {
    return 'Receive a notification the day before at $time if a closure is scheduled for the next day';
  }

  @override
  String dayNotificationTitle(Object day) {
    return 'Weekly recap on $day';
  }

  @override
  String dayNotificationExplanation(Object day, Object time) {
    return 'Receive a notification on $day at $time listing all planned closures for the coming week';
  }

  @override
  String get closingNotificationTitle => 'At closing';

  @override
  String get closingNotificationExplanation =>
      'Receive a notification when the bridge closes';

  @override
  String get notificationClosingChannelName => 'Closing';

  @override
  String get notificationClosingTitle => 'The Chaban bridge has closed ⛔';

  @override
  String notificationClosingBoatMessage(Object boat, Object duration) {
    return 'The Chaban bridge has just closed for $boat 🚢. It will remains closed for $duration 🌉';
  }

  @override
  String notificationClosingMaintenanceMessage(Object duration) {
    return 'The Chaban bridge has just closed for maintenance 🛠. It will remains closed for $duration 🌉';
  }

  @override
  String get openingNotificationTitle => 'At the opening';

  @override
  String get openingNotificationExplanation =>
      'Receive a notification when the bridge open';

  @override
  String get notificationOpeningChannelName => 'Opening';

  @override
  String get notificationOpeningTitle => 'The Chaban bridge is open ✅';

  @override
  String get notificationOpeningMessage =>
      'The Chaban bridge has just opened to traffic 🚲';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get notificationDurationTitle => 'Imminent closure ⚠️';

  @override
  String notificationDurationBoatMessage(
      Object boat, Object timeLeft, Object duration) {
    return 'The Chaban bridge will close in $timeLeft for $boat 🚢. It will remains closed for $duration 🌉';
  }

  @override
  String notificationDurationMaintenanceMessage(
      Object timeLeft, Object duration) {
    return 'The Chaban Bridge will close in $timeLeft for maintenance 🛠. It will remains closed for $duration 🌉';
  }

  @override
  String get notificationDurationChannelName => 'Imminent closures';

  @override
  String get notificationTimeTitle => '🗓 Closing scheduled for tomorrow';

  @override
  String notificationTimeBoatMessage(
      Object boat, Object time, Object duration) {
    return 'The Chaban bridge will close tomorrow at $time for $boat 🚢. It will remains closed for $duration 🌉';
  }

  @override
  String notificationTimeBoatArrival(Object boat) {
    return 'the arrival of the $boat';
  }

  @override
  String notificationTimeBoatDeparture(Object boat) {
    return 'the departure of the $boat';
  }

  @override
  String notificationTimeMaintenanceMessage(Object time, Object duration) {
    return 'The Chaban Bridge will close tomorrow at $time for maintenance 🛠. It will remains closed for $duration 🌉';
  }

  @override
  String get notificationTimeChannelName => 'Next day closings';

  @override
  String selectAboutDialog(String choice) {
    String _temp0 = intl.Intl.selectLogic(
      choice,
      {
        'source_code': 'Source code',
        'privacy_policy': 'Privacy policy',
        'yuhliet_instagram': 'Yuhliet\'s Instagram',
        'city_of_bordeaux': 'City of Bordeaux',
        'bordeaux_open_data': 'Bordeaux Open Data',
        'licenses': 'Licenses',
        'changelog': 'Changelog',
        'other': 'Undefined',
      },
    );
    return '$_temp0';
  }

  @override
  String get notificationDayTitle => '🔮 Closing scheduled';

  @override
  String notificationDayMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Next week, the Chaban Delmas bridge will close $count times',
      one: 'Next week, the Chaban Delmas bridge will only close once',
      zero: 'No closures scheduled for next week',
    );
    return '$_temp0';
  }

  @override
  String get notificationDayChannelName => 'Planned closures';

  @override
  String get status => 'Status';

  @override
  String get loading => 'Loading...';

  @override
  String get dayNotificationAt => 'at';

  @override
  String get favoriteSlotsFrom => 'From';

  @override
  String get favoriteSlotsTo => 'to';

  @override
  String get favoriteSlots => 'My favorite time slots';

  @override
  String get favoriteSlotsDescription =>
      'You can fill in two time slots during which the events of the Chaban bridge are likely to impact you';

  @override
  String favoriteTimeSlotDefaultName(Object index) {
    return 'Time slot n°$index';
  }

  @override
  String get favoriteSlotsInterferenceWarning =>
      'This schedule interferes with one or more time slots';

  @override
  String get favoriteTimeSlotEnabledWarning =>
      'Attention, by activating this parameter you will only receive notifications when an event occurs during one of your time slots';

  @override
  String get favoriteSlotsChooseDay => 'Choose the days of the week';

  @override
  String get notificationsDisabledMessage =>
      'Notifications are disabled. Please enable them to receive alerts about bridge closures.';

  @override
  String get enableNotificationsButton => 'Enable notifications';

  @override
  String moonHarborStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'are',
      one: 'is',
    );
    return '$_temp0 currently docked in the \'Moon Harbor\'';
  }

  @override
  String moonHarborShortStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ships are',
      one: 'ship is',
    );
    return '$count $_temp0 currently in Bordeaux';
  }

  @override
  String get webSite => 'Website';

  @override
  String get wineFestivalSailBoats => 'Wine Festival Sailboats';

  @override
  String get externalLinks => 'External links';

  @override
  String get rate => 'Rate';

  @override
  String get timeFormatTitle => 'Time format';

  @override
  String get timeFormatSubTitle => 'Display hours in 12 or 24 format';

  @override
  String get noMoreForecastsTitle => 'No upcoming events';

  @override
  String get noMoreForecastsMessage =>
      'Bordeaux Métropole has not communicated any closure of the Chaban-Delmas Bridge for the coming weeks.\nStay informed of upcoming closures by returning here regularly';

  @override
  String get shareEventTitle => 'Share';

  @override
  String get calendarEventAddToCalendar => 'Add to calendar';

  @override
  String get calendarEventTitle => 'Closure of the Chaban Delmas bridge';

  @override
  String get calendarEventLocation => 'Bordeaux, Chaban Delmas bridge';

  @override
  String calendarEventMaintenanceDescription(Object duration) {
    return 'The Chaban bridge will close for maintenance 🛠. It will remains closed for $duration 🌉';
  }

  @override
  String calendarEventBoatDescription(Object boat, Object duration) {
    return 'The Chaban bridge will close for $boat 🚢. It will remains closed for $duration 🌉';
  }

  @override
  String get bottomSheetTitle_maintenance => 'Maintenance';

  @override
  String get bottomSheetTitle_boat => 'Passage of vessel(s)';

  @override
  String get bottomSheetAdditionalInfo_maintenance =>
      'The Chaban Bridge is closed for scheduled maintenance.';

  @override
  String get bottomSheetAdditionalInfo_boatLeaving => 'leaving';

  @override
  String get bottomSheetAdditionalInfo_boatArriving => 'arriving';

  @override
  String get bottomSheetAdditionalInfo_boatCrossingTimeDisclaimer =>
      'Arrival and departure times are for information purposes only and are not guaranteed.';

  @override
  String get bottomSheetAdditionalInfo_shareMessage =>
      'Hi, I\'m going to be late, the Chaban Bridge is closed until';
}
