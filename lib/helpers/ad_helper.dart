import 'dart:io';

import 'package:chabo/const.dart';

class AdHelper {
  static String inlineBannerAdUnitId() {
    if (Platform.isAndroid) {
      return Const.androidInlineBanner;
    } else {
      throw UnsupportedError(
        'Unsupported platform to determine the banner unit ID',
      );
    }
  }

  static String nativeAdUnitId() {
    if (Platform.isAndroid) {
      return Const.androidNativeBanner;
    } else {
      throw UnsupportedError(
        'Unsupported platform to determine the banner unit ID',
      );
    }
  }
}
