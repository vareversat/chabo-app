import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebLinkIcon {
  final IconData iconData;
  final String translationKey;
  final String link;

  WebLinkIcon(this.link, this.iconData, this.translationKey);

  void launchURL() async {
    await launchUrlString(link, mode: LaunchMode.externalApplication);
  }
}
