import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @at.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get at;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @the.
  ///
  /// In en, this message translates to:
  /// **'{startWithVowel, select, true{the } other{the }}'**
  String the(String startWithVowel);

  /// No description provided for @circulationClosing.
  ///
  /// In en, this message translates to:
  /// **'closing'**
  String get circulationClosing;

  /// No description provided for @circulationReOpening.
  ///
  /// In en, this message translates to:
  /// **'re opening'**
  String get circulationReOpening;

  /// No description provided for @isClosed.
  ///
  /// In en, this message translates to:
  /// **'closed to traffic'**
  String get isClosed;

  /// No description provided for @daySmall.
  ///
  /// In en, this message translates to:
  /// **'d'**
  String get daySmall;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'good evening'**
  String get goodEvening;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'good morning'**
  String get goodMorning;

  /// No description provided for @nextClosingScheduled.
  ///
  /// In en, this message translates to:
  /// **'next closing scheduled in'**
  String get nextClosingScheduled;

  /// No description provided for @isOpen.
  ///
  /// In en, this message translates to:
  /// **'open to traffic'**
  String get isOpen;

  /// No description provided for @scheduledToOpen.
  ///
  /// In en, this message translates to:
  /// **'scheduled to open in'**
  String get scheduledToOpen;

  /// No description provided for @theChabanBridgeIsOpen.
  ///
  /// In en, this message translates to:
  /// **'the Chaban bridge is open to traffic'**
  String get theChabanBridgeIsOpen;

  /// No description provided for @theChabanBridgeIsClosed.
  ///
  /// In en, this message translates to:
  /// **'the Chaban bridge is closed to traffic'**
  String get theChabanBridgeIsClosed;

  /// No description provided for @theChabanBridgeWillSoonClose.
  ///
  /// In en, this message translates to:
  /// **'the Chaban bridge will soon close to traffic'**
  String get theChabanBridgeWillSoonClose;

  /// No description provided for @willSoonClose.
  ///
  /// In en, this message translates to:
  /// **'close to traffic soon'**
  String get willSoonClose;

  /// No description provided for @settingsClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get settingsClose;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @dialogInformationContentThe.
  ///
  /// In en, this message translates to:
  /// **''**
  String get dialogInformationContentThe;

  /// No description provided for @dialogInformationContentThe2.
  ///
  /// In en, this message translates to:
  /// **'from '**
  String get dialogInformationContentThe2;

  /// No description provided for @dialogInformationContentFromStart.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get dialogInformationContentFromStart;

  /// No description provided for @dialogInformationContentFromEnd.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get dialogInformationContentFromEnd;

  /// No description provided for @dialogInformationContentFromEnd2.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get dialogInformationContentFromEnd2;

  /// No description provided for @dialogInformationContentBridge_closed.
  ///
  /// In en, this message translates to:
  /// **'the Chaban bridge will be closed for'**
  String get dialogInformationContentBridge_closed;

  /// No description provided for @dialogInformationContentBridgeDeparture.
  ///
  /// In en, this message translates to:
  /// **'the departure of the {count, plural, =1 {the} other {the}}'**
  String dialogInformationContentBridgeDeparture(num count);

  /// No description provided for @dialogInformationContentBridgeArrival.
  ///
  /// In en, this message translates to:
  /// **'the arrival of {count, plural, =1 {the} other {the}}'**
  String dialogInformationContentBridgeArrival(num count);

  /// No description provided for @dialogInformationContentBridge_closed_maintenance.
  ///
  /// In en, this message translates to:
  /// **'maintenance'**
  String get dialogInformationContentBridge_closed_maintenance;

  /// No description provided for @dialogInformationContentTime_of_crossing.
  ///
  /// In en, this message translates to:
  /// **'estimated time of crossing'**
  String get dialogInformationContentTime_of_crossing;

  /// No description provided for @errorScreenContentError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorScreenContentError;

  /// No description provided for @errorScreenContentMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while opening this page. Please find technical information below'**
  String get errorScreenContentMessage;

  /// No description provided for @errorScreenContentTechnical_Info.
  ///
  /// In en, this message translates to:
  /// **'Technical information'**
  String get errorScreenContentTechnical_Info;

  /// No description provided for @unableAppInfo.
  ///
  /// In en, this message translates to:
  /// **'Unable to get application information'**
  String get unableAppInfo;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'The Mobile app to get the closing and opening schedules of the Chaban Delmas bridge located in Bordeaux, France'**
  String get appDescription;

  /// No description provided for @informationAboutTheApp.
  ///
  /// In en, this message translates to:
  /// **'Information about the app'**
  String get informationAboutTheApp;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer: provisional closures. Subject to confirmation from the Harbor Master\'s Office.'**
  String get disclaimer;

  /// No description provided for @openSetting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get openSetting;

  /// No description provided for @themeSettingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Application theme'**
  String get themeSettingSubtitle;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System theme'**
  String get systemTheme;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage the notifications of the app'**
  String get notificationsSubtitle;

  /// No description provided for @durationNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'{duration}before'**
  String durationNotificationTitle(Object duration);

  /// No description provided for @durationNotificationExplanation.
  ///
  /// In en, this message translates to:
  /// **'Receive a notification {duration}before the next closing. This value also manages the color change of the current status'**
  String durationNotificationExplanation(Object duration);

  /// No description provided for @timeNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'The day before at {time}'**
  String timeNotificationTitle(Object time);

  /// No description provided for @timeNotificationExplanation.
  ///
  /// In en, this message translates to:
  /// **'Receive a notification the day before at {time} if a closure is scheduled for the next day'**
  String timeNotificationExplanation(Object time);

  /// No description provided for @dayNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly recap on {day}'**
  String dayNotificationTitle(Object day);

  /// No description provided for @dayNotificationExplanation.
  ///
  /// In en, this message translates to:
  /// **'Receive a notification on {day} at {time} listing all planned closures for the coming week'**
  String dayNotificationExplanation(Object day, Object time);

  /// No description provided for @closingNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'At closing'**
  String get closingNotificationTitle;

  /// No description provided for @closingNotificationExplanation.
  ///
  /// In en, this message translates to:
  /// **'Receive a notification when the bridge closes'**
  String get closingNotificationExplanation;

  /// No description provided for @notificationClosingChannelName.
  ///
  /// In en, this message translates to:
  /// **'Closing'**
  String get notificationClosingChannelName;

  /// No description provided for @notificationClosingTitle.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge has closed ⛔'**
  String get notificationClosingTitle;

  /// No description provided for @notificationClosingBoatMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge has just closed for {boat} 🚢. It will remains closed for {duration} 🌉'**
  String notificationClosingBoatMessage(Object boat, Object duration);

  /// No description provided for @notificationClosingMaintenanceMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge has just closed for maintenance 🛠. It will remains closed for {duration} 🌉'**
  String notificationClosingMaintenanceMessage(Object duration);

  /// No description provided for @openingNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'At the opening'**
  String get openingNotificationTitle;

  /// No description provided for @openingNotificationExplanation.
  ///
  /// In en, this message translates to:
  /// **'Receive a notification when the bridge open'**
  String get openingNotificationExplanation;

  /// No description provided for @notificationOpeningChannelName.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get notificationOpeningChannelName;

  /// No description provided for @notificationOpeningTitle.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge is open ✅'**
  String get notificationOpeningTitle;

  /// No description provided for @notificationOpeningMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge has just opened to traffic 🚲'**
  String get notificationOpeningMessage;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @notificationDurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Imminent closure ⚠️'**
  String get notificationDurationTitle;

  /// No description provided for @notificationDurationBoatMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge will close in {timeLeft} for {boat} 🚢. It will remains closed for {duration} 🌉'**
  String notificationDurationBoatMessage(
    Object boat,
    Object timeLeft,
    Object duration,
  );

  /// No description provided for @notificationDurationMaintenanceMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban Bridge will close in {timeLeft} for maintenance 🛠. It will remains closed for {duration} 🌉'**
  String notificationDurationMaintenanceMessage(
    Object timeLeft,
    Object duration,
  );

  /// No description provided for @notificationDurationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Imminent closures'**
  String get notificationDurationChannelName;

  /// No description provided for @notificationTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'🗓 Closing scheduled for tomorrow'**
  String get notificationTimeTitle;

  /// No description provided for @notificationTimeBoatMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban bridge will close tomorrow at {time} for {boat} 🚢. It will remains closed for {duration} 🌉'**
  String notificationTimeBoatMessage(Object boat, Object time, Object duration);

  /// No description provided for @notificationTimeBoatArrival.
  ///
  /// In en, this message translates to:
  /// **'the arrival of the {boat}'**
  String notificationTimeBoatArrival(Object boat);

  /// No description provided for @notificationTimeBoatDeparture.
  ///
  /// In en, this message translates to:
  /// **'the departure of the {boat}'**
  String notificationTimeBoatDeparture(Object boat);

  /// No description provided for @notificationTimeMaintenanceMessage.
  ///
  /// In en, this message translates to:
  /// **'The Chaban Bridge will close tomorrow at {time} for maintenance 🛠. It will remains closed for {duration} 🌉'**
  String notificationTimeMaintenanceMessage(Object time, Object duration);

  /// No description provided for @notificationTimeChannelName.
  ///
  /// In en, this message translates to:
  /// **'Next day closings'**
  String get notificationTimeChannelName;

  /// No description provided for @passedClosure.
  ///
  /// In en, this message translates to:
  /// **'Past closure'**
  String get passedClosure;

  /// No description provided for @selectAboutDialog.
  ///
  /// In en, this message translates to:
  /// **'{choice, select, source_code {Source code} privacy_policy {Privacy policy} yuhliet_instagram {Yuhliet\'s Instagram} city_of_bordeaux {City of Bordeaux} bordeaux_open_data {Bordeaux Open Data} licenses {Licenses} changelog {Changelog} other {Undefined}}'**
  String selectAboutDialog(String choice);

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @notificationDayTitle.
  ///
  /// In en, this message translates to:
  /// **'🔮 Closing scheduled'**
  String get notificationDayTitle;

  /// No description provided for @notificationDayMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No closures scheduled for next week} =1{Next week, the Chaban Delmas bridge will only close once} other{Next week, the Chaban Delmas bridge will close {count} times}}'**
  String notificationDayMessage(num count);

  /// No description provided for @notificationDayChannelName.
  ///
  /// In en, this message translates to:
  /// **'Planned closures'**
  String get notificationDayChannelName;

  /// No description provided for @leftHanded.
  ///
  /// In en, this message translates to:
  /// **'Left handed'**
  String get leftHanded;

  /// No description provided for @rightHanded.
  ///
  /// In en, this message translates to:
  /// **'Right handed'**
  String get rightHanded;

  /// No description provided for @statusLoadMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading of the bridge\'s current status'**
  String get statusLoadMessage;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @dayNotificationAt.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get dayNotificationAt;

  /// No description provided for @favoriteSlotsFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get favoriteSlotsFrom;

  /// No description provided for @favoriteSlotsTo.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get favoriteSlotsTo;

  /// No description provided for @favoriteSlots.
  ///
  /// In en, this message translates to:
  /// **'My favorite time slots'**
  String get favoriteSlots;

  /// No description provided for @favoriteSlotsDescription.
  ///
  /// In en, this message translates to:
  /// **'You can fill in two time slots during which the events of the Chaban bridge are likely to impact you'**
  String get favoriteSlotsDescription;

  /// No description provided for @favoriteTimeSlotDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Time slot n°{index}'**
  String favoriteTimeSlotDefaultName(Object index);

  /// No description provided for @favoriteSlotsInterferenceWarning.
  ///
  /// In en, this message translates to:
  /// **'This schedule interferes with one or more time slots'**
  String get favoriteSlotsInterferenceWarning;

  /// No description provided for @favoriteTimeSlotEnabledWarning.
  ///
  /// In en, this message translates to:
  /// **'Attention, by activating this parameter you will only receive notifications when an event occurs during one of your time slots'**
  String get favoriteTimeSlotEnabledWarning;

  /// No description provided for @favoriteSlotsChooseDay.
  ///
  /// In en, this message translates to:
  /// **'Choose the days of the week'**
  String get favoriteSlotsChooseDay;

  /// No description provided for @moonHarborStatus.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1 {is} other {are}} currently docked in the \'Moon Harbor\''**
  String moonHarborStatus(num count);

  /// No description provided for @moonHarborShortStatus.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1 {ship is} other {ships are}} currently in Bordeaux'**
  String moonHarborShortStatus(num count);

  /// No description provided for @wineFestivalSailBoats.
  ///
  /// In en, this message translates to:
  /// **'Wine Festival Sailboats'**
  String get wineFestivalSailBoats;

  /// No description provided for @externalLinks.
  ///
  /// In en, this message translates to:
  /// **'External links'**
  String get externalLinks;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @timeFormatSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get timeFormatSubTitle;

  /// No description provided for @noMoreForecastsTitle.
  ///
  /// In en, this message translates to:
  /// **'No upcoming events'**
  String get noMoreForecastsTitle;

  /// No description provided for @noMoreForecastsMessage.
  ///
  /// In en, this message translates to:
  /// **'Bordeaux Métropole has not communicated any closure of the Chaban-Delmas Bridge for the coming weeks.\nStay informed of upcoming closures by returning here regularly'**
  String get noMoreForecastsMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
