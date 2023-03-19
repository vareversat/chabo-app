import 'package:chabo/const.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Boat {
  final String name;
  final bool isLeaving;

  Boat({required this.name, required this.isLeaving});

  void _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  TextSpan toLocalizedString(BuildContext context) {
    final textSpanLink = TextSpan(
      recognizer: TapGestureRecognizer()
        ..onTap = () => _launchURL(
              Const.vesselFinderLink.replaceAll(
                Const.vesselFinderLinkPlaceholder,
                name,
              ),
            ),
      text: name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.boatColor,
        decoration: TextDecoration.underline,
      ),
    );
    if (isLeaving) {
      return TextSpan(children: [
        TextSpan(
            text:
                '${AppLocalizations.of(context)!.dialogInformationContentBridgeDeparture} '),
        textSpanLink,
      ]);
    } else {
      return TextSpan(children: [
        TextSpan(
            text:
                '${AppLocalizations.of(context)!.dialogInformationContentBridgeArrival} '),
        textSpanLink,
      ]);
    }
  }
}
