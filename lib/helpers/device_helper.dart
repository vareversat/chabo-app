import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceHelper {
  static computePreferredOrientation(BuildContext context) {
    if (isMobile(context)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  static isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static isMobile(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    return shortestSide < 620;
  }
}
