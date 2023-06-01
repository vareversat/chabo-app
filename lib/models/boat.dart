import 'package:chabo/const.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Boat extends Equatable {
  final String name;
  final bool isLeaving;

  const Boat({required this.name, required this.isLeaving});

  void _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  TextSpan toLocalizedTextSpan(BuildContext context, bool colored) {
    return TextSpan(
      recognizer: TapGestureRecognizer()
        ..onTap = () =>
            _launchURL(
              Const.vesselFinderLink.replaceAll(
                Const.vesselFinderLinkPlaceholder,
                name,
              ),
            ),
      text: name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: colored ? Theme
            .of(context)
            .colorScheme
            .boatColor : Theme
            .of(context)
            .dialogBackgroundColor,
        decoration: TextDecoration.underline,
      ),
    );
  }
  TextSpan toLocalizedStatusTextSpan(BuildContext context, bool colored) {

    return isLeaving
        ? TextSpan(
            children: [
              TextSpan(
                text:
                    '${AppLocalizations.of(context)!.dialogInformationContentBridgeDeparture} ',
              ),
              toLocalizedTextSpan(context, colored),
            ],
          )
        : TextSpan(
            children: [
              TextSpan(
                text:
                    '${AppLocalizations.of(context)!.dialogInformationContentBridgeArrival} ',
              ),
              toLocalizedTextSpan(context, colored),
            ],
          );
  }

  @override
  List<Object?> get props => [name, isLeaving];
}
