import 'dart:io';

import 'package:chabo/const.dart';

class AdHelper {
  static String bannerAdUnitId() {
    if (Platform.isAndroid) {
      return Const.androidInlineBanner;
    } else {
      throw UnsupportedError(
          'Unsupported platform to determine the banner unit ID');
    }
  }
}
