import 'dart:developer' as developer;

import 'package:chabo/chabo.dart';
import 'package:chabo/const.dart';
import 'package:chabo/service/consent_form_service.dart';
import 'package:chabo/service/notification_service.dart';
import 'package:chabo/service/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final StorageService storageService = StorageService(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  final ConsentFormService consentFormService =
      ConsentFormService(consentRequestParameters: ConsentRequestParameters());
  final NotificationService notificationService =
      await NotificationService.create(
    storageService: storageService,
  );

  /// Initialize the Google Ads SDK
  MobileAds.instance.initialize();

  /// Show consent dialog using the User Messaging Platform (UPM)
  consentFormService.showConsentForm();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(Const.oflLicensePath);
    yield LicenseEntryWithLineBreaks([Const.oflLicenseEntryName], license);
  });

  /// Fetch app release to inject them into Sentry
  final appRelease = await PackageInfo.fromPlatform();
  final formattedRelease =
      '${appRelease.packageName}@${appRelease.version}+${appRelease.buildNumber}'
          .toLowerCase();

  /// Fetch running env
  const env =
      String.fromEnvironment(Const.envKey, defaultValue: Const.defaultEnv);

  developer.log(
    '##### HI ! Starting $formattedRelease in $env mode #####',
    name: 'chabo.main',
  );

  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment(Const.sentryDSNEnvKey);
      options.tracesSampleRate = 0.5;
      options.release = formattedRelease;
      options.environment = env;
    },
    appRunner: () => runApp(
      SentryUserInteractionWidget(
        child: Chabo(
          storageService: storageService,
          notificationService: notificationService,
        ),
      ),
    ),
  );
}
