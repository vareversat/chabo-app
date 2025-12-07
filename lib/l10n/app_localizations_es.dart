// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get at => 'a las';

  @override
  String get and => 'y';

  @override
  String the(String startWithVowel) {
    String _temp0 = intl.Intl.selectLogic(startWithVowel, {
      'true': 'el ',
      'other': 'el ',
    });
    return '$_temp0';
  }

  @override
  String get circulationClosing => 'cerrado';

  @override
  String get circulationReOpening => 'reapertura';

  @override
  String get isClosed => 'cerrado al tráfico';

  @override
  String get daySmall => 'd';

  @override
  String get goodAfternoon => 'buenas tardes';

  @override
  String get goodEvening => 'buenas noches';

  @override
  String get goodMorning => 'buenos días';

  @override
  String get nextClosingScheduled => 'próximo cierre programado en';

  @override
  String get isOpen => 'abierto al tráfico';

  @override
  String get scheduledToOpen => 'programado para abrir en';

  @override
  String get theChabanBridgeIsOpen =>
      'el puente Chaban está abierto al tráfico';

  @override
  String get theChabanBridgeIsClosed =>
      'el puente Chaban está cerrado al tráfico';

  @override
  String get theChabanBridgeWillSoonClose =>
      'el puente Chaban cerca del tráfico pronto';

  @override
  String get willSoonClose => 'cerca del tráfico pronto';

  @override
  String get settingsClose => 'Cerca';

  @override
  String get notificationsTitle => 'Notificaciónes';

  @override
  String get information => 'Información';

  @override
  String get dialogInformationContentThe => 'el ';

  @override
  String get dialogInformationContentThe2 => 'desde ';

  @override
  String get dialogInformationContentFromStart => 'desde';

  @override
  String get dialogInformationContentFromEnd => 'hasta';

  @override
  String get dialogInformationContentFromEnd2 => 'a';

  @override
  String get dialogInformationContentBridge_closed =>
      'el puente Chaban estará cerrado por';

  @override
  String dialogInformationContentBridgeDeparture(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'de los',
      one: 'del',
    );
    return 'la salida $_temp0';
  }

  @override
  String dialogInformationContentBridgeArrival(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'de los',
      one: 'del',
    );
    return 'la llegada $_temp0';
  }

  @override
  String get dialogInformationContentBridge_closed_maintenance =>
      'mantenimiento';

  @override
  String get dialogInformationContentTime_of_crossing =>
      'hora estimada de cruce';

  @override
  String get errorScreenContentError => 'Error';

  @override
  String get errorScreenContentMessage =>
      'Se produjo un error al abrir esta página. Encuentre la información técnica a continuación';

  @override
  String get errorScreenContentTechnical_Info => 'Información técnica';

  @override
  String get unableAppInfo =>
      'No se puede obtener información de la aplicación';

  @override
  String get appDescription =>
      'La aplicación móvil para obtener los horarios de cierre y apertura del puente Chaban Delmas ubicado en Bordeaux, Francia';

  @override
  String get informationAboutTheApp => 'Información sobre la aplicación';

  @override
  String get about => 'Acerca de';

  @override
  String get disclaimer =>
      'Descargo de responsabilidad: cierres provisionales. Sujeto a confirmación de la Capitanía de Puerto.';

  @override
  String get openSetting => 'Ajustes';

  @override
  String get themeSettingSubtitle => 'Tema de la aplicación';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get systemTheme => 'Tema del sistema';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationsSubtitle =>
      'Administre las notificaciones de la aplicación';

  @override
  String durationNotificationTitle(Object duration) {
    return '${duration}antes';
  }

  @override
  String durationNotificationExplanation(Object duration) {
    return 'Reciba una notificación ${duration}antes del próximo cierre. Este valor también gestiona el cambio de color del estado actual';
  }

  @override
  String timeNotificationTitle(Object time) {
    return 'El día antes a las $time';
  }

  @override
  String timeNotificationExplanation(Object time) {
    return 'Reciba una notificación el día anterior a las $time si hay un cierre programado para el día siguiente';
  }

  @override
  String dayNotificationTitle(Object day) {
    return 'Resumen semanal el $day';
  }

  @override
  String dayNotificationExplanation(Object day, Object time) {
    return 'Reciba una notificación el $day a las $time que enumere todos los cierres planeados para la próxima semana';
  }

  @override
  String get closingNotificationTitle => 'En el cierre';

  @override
  String get closingNotificationExplanation =>
      'Reciba una notificación cuando el puente cierre';

  @override
  String get notificationClosingChannelName => 'Cierre';

  @override
  String get notificationClosingTitle => 'El puente Chaban ha cerrado ⛔';

  @override
  String notificationClosingBoatMessage(Object boat, Object duration) {
    return 'El puente Chaban acaba de cerrarse para $boat 🚢. Permanecerá cerrado durante $duration 🌉';
  }

  @override
  String notificationClosingMaintenanceMessage(Object duration) {
    return 'El puente Chaban acaba de cerrarse para mantenimiento 🛠. Permanecerá cerrado durante $duration 🌉';
  }

  @override
  String get openingNotificationTitle => 'En la apertura';

  @override
  String get openingNotificationExplanation =>
      'Reciba una notificación cuando el puente abra';

  @override
  String get notificationOpeningChannelName => 'Apertura';

  @override
  String get notificationOpeningTitle => 'El puente Chaban está abierto ✅';

  @override
  String get notificationOpeningMessage =>
      'El puente Chaban acaba de abrirse al tráfico 🚲';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get notificationDurationTitle => 'Cierre inminente ⚠️';

  @override
  String notificationDurationBoatMessage(
    Object boat,
    Object timeLeft,
    Object duration,
  ) {
    return 'El puente Chaban cerrará en $timeLeft para $boat 🚢. Permanecerá cerrado durante $duration 🌉';
  }

  @override
  String notificationDurationMaintenanceMessage(
    Object timeLeft,
    Object duration,
  ) {
    return 'El puente Chaban cerrará en $timeLeft para mantenimiento 🛠. Permanecerá cerrado durante $duration 🌉';
  }

  @override
  String get notificationDurationChannelName => 'Cierres inminentes';

  @override
  String get notificationTimeTitle => '🗓 Cierre programado para mañana';

  @override
  String notificationTimeBoatMessage(
    Object boat,
    Object time,
    Object duration,
  ) {
    return 'El puente Chaban cerrará mañana a las $time para $boat 🚢. Permanecerá cerrado durante $duration 🌉';
  }

  @override
  String notificationTimeBoatArrival(Object boat) {
    return 'la llegada del $boat';
  }

  @override
  String notificationTimeBoatDeparture(Object boat) {
    return 'la salida del $boat';
  }

  @override
  String notificationTimeMaintenanceMessage(Object time, Object duration) {
    return 'El puente Chaban cerrará mañana a las $time por mantenimiento 🛠. Permanecerá cerrado durante $duration 🌉';
  }

  @override
  String get notificationTimeChannelName => 'Cierres del próximo día';

  @override
  String get passedClosure => 'Cierre pasado';

  @override
  String selectAboutDialog(String choice) {
    String _temp0 = intl.Intl.selectLogic(choice, {
      'source_code': 'Código fuente',
      'privacy_policy': 'Política de privacidad',
      'yuhliet_instagram': 'Instagram de Yuhliet\'s',
      'city_of_bordeaux': 'Ciudad de Bordeaux',
      'bordeaux_open_data': 'Bordeaux Open Data',
      'licenses': 'Licencias',
      'changelog': 'Registro de cambios',
      'other': 'Undefined',
    });
    return '$_temp0';
  }

  @override
  String get day => 'Día';

  @override
  String get notificationDayTitle => '🔮 Cierre programado';

  @override
  String notificationDayMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'La próxima semana, el puente Chaban Delmas cerrará $count veces',
      one: 'La próxima semana, el puente Chaban Delmas solo cerrará una vez',
      zero: 'No hay cierres programados para la próxima semana',
    );
    return '$_temp0';
  }

  @override
  String get notificationDayChannelName => 'Cierres planificados';

  @override
  String get leftHanded => 'Zurdo.a';

  @override
  String get rightHanded => 'Diestro.a';

  @override
  String get statusLoadMessage => 'Carga del estado actual del puente';

  @override
  String get loading => 'Cargando...';

  @override
  String get dayNotificationAt => 'en las';

  @override
  String get favoriteSlotsFrom => 'De';

  @override
  String get favoriteSlotsTo => 'a';

  @override
  String get favoriteSlots => 'Mis franjas horarias favoritas';

  @override
  String get favoriteSlotsDescription =>
      'Puede completar dos intervalos de tiempo durante los cuales es probable que los eventos del puente Chaban lo afecten';

  @override
  String favoriteTimeSlotDefaultName(Object index) {
    return 'Franja horaria n°$index';
  }

  @override
  String get favoriteSlotsInterferenceWarning =>
      'Este horario interfiere con uno o más intervalos de tiempo';

  @override
  String get favoriteTimeSlotEnabledWarning =>
      'Atención, al activar este parámetro solo recibirás notificaciones cuando ocurra un evento durante una de tus franjas horarias';

  @override
  String get favoriteSlotsChooseDay => 'Elegir los días de la semana';

  @override
  String moonHarborStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'están actualmente amarrados',
      one: 'está actualmente amarrado',
    );
    return '$_temp0 en el \'Puerto de la Luna\'';
  }

  @override
  String moonHarborShortStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'buques están actualmente',
      one: 'barco está actualmente',
    );
    return '$count $_temp0 en Bordeaux';
  }

  @override
  String get wineFestivalSailBoats => 'Veleros de la Fiesta del Vino';

  @override
  String get externalLinks => 'Enlaces externos';

  @override
  String get rate => 'Califica';

  @override
  String get timeFormatSubTitle => 'Formato de hora';

  @override
  String get noMoreForecastsTitle => 'Ningún acontecimiento por venir';

  @override
  String get noMoreForecastsMessage =>
      'Bordeaux Métropole no ha comunicado ningún cierre del Puente Chaban-Delmas para las próximas semanas.\nManténgase informado de los próximos cierres volviendo aquí regularmente';
}
