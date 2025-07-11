// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get at => 'à';

  @override
  String get and => 'et';

  @override
  String the(String startWithVowel) {
    String _temp0 = intl.Intl.selectLogic(startWithVowel, {
      'true': 'l\'',
      'other': 'le ',
    });
    return '$_temp0';
  }

  @override
  String get circulationClosing => 'fermeture';

  @override
  String get circulationReOpening => 'réouverture';

  @override
  String get isClosed => 'fermé à la circulation';

  @override
  String get daySmall => 'j';

  @override
  String get goodAfternoon => 'bonne après-midi';

  @override
  String get goodEvening => 'bonsoir';

  @override
  String get goodMorning => 'bonjour';

  @override
  String get nextClosingScheduled => 'prochaine fermeture prévue dans';

  @override
  String get isOpen => 'ouvert à la circulation';

  @override
  String get scheduledToOpen => 'ouverture prévue dans';

  @override
  String get theChabanBridgeIsOpen =>
      'le pont Chaban est ouvert à la circulation';

  @override
  String get theChabanBridgeIsClosed =>
      'le pont Chaban est fermé à la circulation';

  @override
  String get theChabanBridgeWillSoonClose =>
      'le pont Chaban ferme bientôt à la circulation';

  @override
  String get willSoonClose => 'ferme bientôt à la circulation';

  @override
  String get settingsClose => 'Fermer';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get information => 'Information';

  @override
  String get dialogInformationContentThe => 'le ';

  @override
  String get dialogInformationContentThe2 => 'du ';

  @override
  String get dialogInformationContentFromStart => 'de';

  @override
  String get dialogInformationContentFromEnd => 'à';

  @override
  String get dialogInformationContentFromEnd2 => 'au';

  @override
  String get dialogInformationContentBridge_closed =>
      'le pont Chaban sera fermé pour';

  @override
  String dialogInformationContentBridgeDeparture(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'des',
      one: 'du',
    );
    return 'le départ $_temp0';
  }

  @override
  String dialogInformationContentBridgeArrival(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'des',
      one: 'du',
    );
    return 'l\'arrivée $_temp0';
  }

  @override
  String get dialogInformationContentBridge_closed_maintenance => 'maintenance';

  @override
  String get dialogInformationContentTime_of_crossing =>
      'heure de passage estimée';

  @override
  String get errorScreenContentError => 'Erreur';

  @override
  String get errorScreenContentMessage =>
      'Une erreur est survenue lors de l\'ouverture de cette page. Veuillez trouver les informations techniques ci-dessous';

  @override
  String get errorScreenContentTechnical_Info => 'Informations techniques';

  @override
  String get unableAppInfo =>
      'Impossible d\'obtenir les informations de l\'application';

  @override
  String get appDescription =>
      'L\'application Mobile pour connaître les horaires de fermeture et d\'ouverture du pont Chaban Delmas situé à Bordeaux, France';

  @override
  String get informationAboutTheApp => 'Informations concernant l\'application';

  @override
  String get about => 'À propos';

  @override
  String get disclaimer =>
      'Avis de non-responsabilité : fermetures provisoires. Sous réserve de confirmation de la Capitainerie.';

  @override
  String get openSetting => 'Paramètres';

  @override
  String get themeSettingSubtitle => 'Thème de l\'application';

  @override
  String get lightTheme => 'Thème clair';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get systemTheme => 'Thème système';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle =>
      'Gérer les notifications de l\'application';

  @override
  String durationNotificationTitle(Object duration) {
    return '${duration}avant';
  }

  @override
  String durationNotificationExplanation(Object duration) {
    return 'Recevoir une notification ${duration}avant la prochaine fermeture. Cette valeur gère aussi le changement de couleur du statut actuel';
  }

  @override
  String timeNotificationTitle(Object time) {
    return 'La veille à $time';
  }

  @override
  String timeNotificationExplanation(Object time) {
    return 'Recevoir une notification la veille à $time si une fermeture est prévue le lendemain';
  }

  @override
  String dayNotificationTitle(Object day) {
    return 'Récap hebdo le $day';
  }

  @override
  String dayNotificationExplanation(Object day, Object time) {
    return 'Recevoir une notification le $day à $time listant toutes les fermetures prévues pour la semaine qui arrive';
  }

  @override
  String get closingNotificationTitle => 'À la fermeture';

  @override
  String get closingNotificationExplanation =>
      'Recevoir une notification quand le pont ferme à la circulation';

  @override
  String get notificationClosingChannelName => 'Fermeture';

  @override
  String get notificationClosingTitle => 'Le pont Chaban est fermé ⛔';

  @override
  String notificationClosingBoatMessage(Object boat, Object duration) {
    return 'Le pont Chaban vient de fermer pour $boat 🚢. Il restera fermé pendant $duration 🌉';
  }

  @override
  String notificationClosingMaintenanceMessage(Object duration) {
    return 'Le pont Chaban vient de fermer pour maintenance 🛠. Il restera fermé pendant $duration 🌉';
  }

  @override
  String get openingNotificationTitle => 'À l\'ouverture';

  @override
  String get openingNotificationExplanation =>
      'Recevoir une notification quand le pont ouvre à la circulation';

  @override
  String get notificationOpeningChannelName => 'Ouverture';

  @override
  String get notificationOpeningTitle => 'Le pont Chaban est ouvert ✅';

  @override
  String get notificationOpeningMessage =>
      'Le pont Chaban vient de rouvir à la circulation 🚲';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get notificationDurationTitle => 'Fermeture imminante ⚠️';

  @override
  String notificationDurationBoatMessage(
    Object boat,
    Object timeLeft,
    Object duration,
  ) {
    return 'Le pont Chaban fermera dans $timeLeft pour $boat 🚢. Il restera fermé pendant $duration 🌉';
  }

  @override
  String notificationDurationMaintenanceMessage(
    Object timeLeft,
    Object duration,
  ) {
    return 'Le pont Chaban fermera dans $timeLeft pour maintenance 🛠. Il restera fermé pendant $duration 🌉';
  }

  @override
  String get notificationDurationChannelName => 'Fermetures imminentes';

  @override
  String get notificationTimeTitle => '🗓 Fermeture prévue pour demain';

  @override
  String notificationTimeBoatMessage(
    Object boat,
    Object time,
    Object duration,
  ) {
    return 'Le pont Chaban fermera demain à $time pour $boat 🚢. Il restera fermé pendant $duration 🌉';
  }

  @override
  String notificationTimeBoatArrival(Object boat) {
    return 'l\'arrivée du $boat';
  }

  @override
  String notificationTimeBoatDeparture(Object boat) {
    return 'le départ du $boat';
  }

  @override
  String notificationTimeMaintenanceMessage(Object time, Object duration) {
    return 'Le pont Chaban fermera demain à $time pour maintenance 🛠. Il restera fermé pendant $duration 🌉';
  }

  @override
  String get notificationTimeChannelName => 'Fermetures du lendemain';

  @override
  String get passedClosure => 'Fermeture passée';

  @override
  String selectAboutDialog(String choice) {
    String _temp0 = intl.Intl.selectLogic(choice, {
      'source_code': 'Code source',
      'privacy_policy': 'Politique de confidentialité',
      'yuhliet_instagram': 'Instagram de Yuhliet\'s',
      'city_of_bordeaux': 'Ville de Bordeaux',
      'bordeaux_open_data': 'Bordeaux Open Data',
      'changelog': 'Journal des modifications',
      'licenses': 'Licences',
      'other': 'Undefined',
    });
    return '$_temp0';
  }

  @override
  String get day => 'Jour';

  @override
  String get notificationDayTitle => '🔮 Fermetures prévues';

  @override
  String notificationDayMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'La semaine prochaine, le pont Chaban Delmas fermera à $count reprises',
      one:
          'La semaine prochaine, le pont Chaban Delmas ne fermera qu\'une seul fois',
      zero: 'Aucune fermetures de prévue pour la semaine prochaine',
    );
    return '$_temp0';
  }

  @override
  String get notificationDayChannelName => 'Fermetures prévues';

  @override
  String get leftHanded => 'Gaucher.ère';

  @override
  String get rightHanded => 'Droitier.ère';

  @override
  String get statusLoadMessage => 'Chargement de l\'état actuel du pont';

  @override
  String get loading => 'Chargement...';

  @override
  String get dayNotificationAt => 'à';

  @override
  String get favoriteSlotsFrom => 'De';

  @override
  String get favoriteSlotsTo => 'à';

  @override
  String get favoriteSlots => 'Mes créneaux horaires favoris';

  @override
  String get favoriteSlotsDescription =>
      'Vous pouvez renseigner deux créneaux durant lesquels les évènements du pont Chaban risques de vous impacter';

  @override
  String favoriteTimeSlotDefaultName(Object index) {
    return 'Créneau n°$index';
  }

  @override
  String get favoriteSlotsInterferenceWarning =>
      'Cette prévision interfère avec un ou plusieurs créneaux';

  @override
  String get favoriteTimeSlotEnabledWarning =>
      'Attention, en activant ce paramètres vous allez uniquement recevoir les notifications lorsqu\'un évèmenent se produit durant l\'un de vos créneaux';

  @override
  String get favoriteSlotsChooseDay => 'Choisir les jours de la semaine';

  @override
  String moonHarborStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sont actuellement amarrés',
      one: 'est actuellement amarré',
    );
    return '$_temp0 au \'Port de la Lune\'';
  }

  @override
  String moonHarborShortStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'navires sont actuellement',
      one: 'navire est actuellement',
    );
    return '$count $_temp0 à Bordeaux';
  }

  @override
  String get wineFestivalSailBoats => 'Voiliers de la fête du vin';

  @override
  String get externalLinks => 'Liens externes';

  @override
  String get rate => 'Noter';

  @override
  String get timeFormatSubTitle => 'Format d\'affichage des heures';

  @override
  String get noMoreForecastsTitle => 'Aucun évènement à venir';

  @override
  String get noMoreForecastsMessage =>
      'Bordeaux Métropole n\'a communiqué aucune fermeture du Pont Chaban-Delmas pour les prochaines semaines.\nTenez-vous informer des prochaines fermetures en revenant ici régulièrement';
}
