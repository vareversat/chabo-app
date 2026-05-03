import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebLinkIcon {
  final Icon icon;
  final String translationKey;
  final String link;

  WebLinkIcon(this.link, this.icon, this.translationKey);

  void launchURL(String regionCode) async {
    await launchUrlString(
      link.replaceAll('%', regionCode),
      mode: LaunchMode.externalApplication,
    );
  }
}
