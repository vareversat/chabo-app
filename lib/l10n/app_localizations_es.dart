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
  String get credits => 'Créditos';

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
  String get isClosed => 'cerrado';

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
  String get isOpen => 'abierto';

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
  String get willSoonClose => 'cerrar pronto';

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
  String get dialogInformationContentTime_of_crossing =>
      'hora de paso estimada';

  @override
  String get duration => 'Duración';

  @override
  String get errorScreenContentError => 'Error';

  @override
  String get errorScreenContentMessage =>
      'Se ha producido un error al abrir esta pàgina. Encuentre información técnica a continuación';

  @override
  String get errorScreenContentTechnical_Info => 'Información técnica';

  @override
  String get unableAppInfo =>
      'No se puede recuperar la información de la aplicación';

  @override
  String get appDescription =>
      'Aplicación móvil para obtener los horarios de cierre y apertura del puente Chaban-Delmas ubicado en Burdeos, Francia';

  @override
  String get informationAboutTheApp => 'Información sobre la aplicación';

  @override
  String get about => 'Acerca de';

  @override
  String get disclaimer =>
      'Aviso: cierres provisionales. Sujeto a confirmación de la Capitania de Puerto.';

  @override
  String get openSetting => 'Configuración';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get themeSettingSubTitle => 'Cambiar la apariencia de la aplicación';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get schedules => 'Horarios';

  @override
  String get systemTheme => 'Tema del sistema';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationsSubtitle =>
      'Administrar las notificaciones de la aplicación';

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
    return 'Reciba una notificación el $day a las $time que enumere todos los cierres planificados para la próxima semana';
  }

  @override
  String get closingNotificationTitle => 'Al cierre';

  @override
  String get closingNotificationExplanation =>
      'Reciba una notificación cuando el puente se cierra';

  @override
  String get notificationClosingChannelName => 'Cierre';

  @override
  String get notificationClosingTitle => 'El puente Chaban está cerrado ⛔';

  @override
  String notificationClosingBoatMessage(Object boat, Object duration) {
    return 'El puente Chaban acaba de cerrarse para $boat 🚢. Permanecerà cerrado durante $duration 🌉';
  }

  @override
  String notificationClosingMaintenanceMessage(Object duration) {
    return 'El puente Chaban acaba de cerrarse para mantenimiento 🛠. Permanecerà cerrado durante $duration 🌉';
  }

  @override
  String get openingNotificationTitle => 'En la apertura';

  @override
  String get openingNotificationExplanation =>
      'Reciba una notificación cuando el puente se abre';

  @override
  String get notificationOpeningChannelName => 'Apertura';

  @override
  String get notificationOpeningTitle => 'El puente Chaban está abierto ✅';

  @override
  String get notificationOpeningMessage =>
      'El puente Chaban acaba de abrirse al tràfico 🚲';

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
    return 'El puente Chaban se cerrarà en $timeLeft para $boat 🚢. Permanecerà cerrado durante $duration 🌉';
  }

  @override
  String notificationDurationMaintenanceMessage(
    Object timeLeft,
    Object duration,
  ) {
    return 'El puente Chaban se cerrarà en $timeLeft para mantenimiento 🛠. Permanecerà cerrado durante $duration 🌉';
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
    return 'El puente Chaban se cerrarà mañana a las $time para $boat 🚢. Permanecerà cerrado durante $duration 🌉';
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
    return 'El puente Chaban se cerrarà mañana a las $time para mantenimiento 🛠. Permanecerà cerrado durante $duration 🌉';
  }

  @override
  String get notificationTimeChannelName => 'Cierres del dìa siguiente';

  @override
  String get passedClosure => 'Cierre pasado';

  @override
  String selectAboutDialog(String choice) {
    String _temp0 = intl.Intl.selectLogic(choice, {
      'source_code': 'Código fuente',
      'privacy_policy': 'Polìtica de privacidad',
      'yuhliet_instagram': 'Instagram de Yuhliet',
      'city_of_bordeaux': 'Ciudad de Burdeos',
      'bordeaux_open_data': 'Bordeaux Open Data',
      'licenses': 'Licencias',
      'changelog': 'Registro de cambios',
      'other': 'Indefinido',
    });
    return '$_temp0';
  }

  @override
  String get day => 'Dìa';

  @override
  String get notificationDayTitle => '🔮 Cierre programado';

  @override
  String notificationDayMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'La próxima semana, el puente Chaban-Delmas se cerrarà $count veces',
      one: 'La próxima semana, el puente Chaban-Delmas solo se cerrarà una vez',
      zero: 'Ningún cierre programado para la próxima semana',
    );
    return '$_temp0';
  }

  @override
  String get notificationDayChannelName => 'Cierres programados';

  @override
  String get leftHanded => 'Zurdo';

  @override
  String get rightHanded => 'Diestro';

  @override
  String get status => 'Estado';

  @override
  String get statusLoadMessage => 'Cargando el estado actual del puente';

  @override
  String get loading => 'Cargando...';
  @override
  String get refreshData => 'Actualizar';
  @override
  String get refreshingData => 'Actualizando...';
  @override
  String get cachedDataTooltip =>
      'Sin conexión o API no disponible: mostrando datos en caché';
  @override
  String get lastRefreshLabel => 'Última actualización';

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
      'Este horario interfiere con uno o màs intervalos de tiempo';

  @override
  String get favoriteTimeSlotEnabledWarning =>
      'Atención, al activar este paràmetro solo recibiràs notificaciones cuando ocurra un evento durante una de tus franjas horarias';

  @override
  String get favoriteSlotsChooseDay => 'Elegir los dìas de la semana';

  @override
  String moonHarborStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'estàn actualmente amarrados',
      one: 'está actualmente amarrado',
    );
    return '$_temp0 en el \'Puerto de la Luna\'';
  }

  @override
  String moonHarborShortStatus(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'buques estàn actualmente',
      one: 'barco está actualmente',
    );
    return '$count $_temp0 en Bordeaux';
  }

  @override
  String get webSite => 'Sitio web';

  @override
  String get wineFestivalSailBoats => 'Veleros de la Fiesta del Vino';

  @override
  String get externalLinks => 'Enlaces externos';

  @override
  String get rate => 'Califica';

  @override
  String get timeFormatTitle => 'Formato de hora';

  @override
  String get timeFormatSubTitle =>
      'Visualización de las horas en formato de 12 o 24 horas.';

  @override
  String get noMoreForecastsTitle => 'Ningún acontecimiento por venir';

  @override
  String get noMoreForecastsMessage =>
      'Bordeaux Métropole no ha comunicado ningún cierre del Puente Chaban-Delmas para las próximas semanas.\nManténgase informado de los próximos cierres volviendo aquì regularmente';

  @override
  String get shareEventTitle => 'Compartir';

  @override
  String get calendarEventAddToCalendar => 'Añadir al calendario';

  @override
  String get calendarEventTitle => 'Cierre del puente Chaban Delmas';

  @override
  String get calendarEventLocation => 'Bordeaux, puente Chaban Delmas';

  @override
  String calendarEventMaintenanceDescription(Object duration) {
    return '\"El puente Chaban permanecerá cerrado para mantenimiento 🛠. Permanecerà cerrado durante $duration 🌉';
  }

  @override
  String calendarEventBoatDescription(Object boat, Object duration) {
    return 'El puente Chaban permanecerá cerrado para $boat 🚢. Permanecerà cerrado durante $duration 🌉';
  }

  @override
  String get bottomSheetTitle_maintenance => 'Mantenimiento';

  @override
  String get bottomSheetTitle_boat => 'Paso de la(s) embarcación(es)';

  @override
  String get bottomSheetAdditionalInfo_maintenance =>
      'El puente Chaban está cerrado por mantenimiento programado.';

  @override
  String get bottomSheetAdditionalInfo_boatLeaving => 'llegada';

  @override
  String get bottomSheetAdditionalInfo_boatArriving => 'partida';

  @override
  String get bottomSheetAdditionalInfo_boatCrossingTimeDisclaimer =>
      'Los horarios de llegada y salida son únicamente a título informativo y no están garantizados.';

  @override
  String get bottomSheetAdditionalInfo_shareMessage =>
      'Hola, voy a llegar tarde; el puente Chaban está cerrado hasta';
}
