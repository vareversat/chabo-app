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
  late final bool isWineFestivalSailBoats;

  Boat({
    required this.name,
    required this.isLeaving,
  }) {
    isWineFestivalSailBoats = name == Const.specialWineFestivalBoatsEvent;
  }

  void _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  TextSpan toLocalizedTextSpan(BuildContext context, bool colored) {
    final baseURL = isWineFestivalSailBoats
        ? Const.bordeauxWineFestivalSailingShipLink
        : Const.vesselFinderLink;
    final text = isWineFestivalSailBoats
        ? AppLocalizations.of(context)!.wineFestivalSailBoats
        : name;

    return TextSpan(
      recognizer: TapGestureRecognizer()
        ..onTap = () => _launchURL(
              baseURL.replaceAll(
                Const.vesselFinderLinkPlaceholder,
                name,
              ),
            ),
      text: text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: colored
            ? isWineFestivalSailBoats
                ? Theme.of(context).colorScheme.bordeauxColor
                : Theme.of(context).colorScheme.boatColor
            : Theme.of(context).dialogBackgroundColor,
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
                    '${AppLocalizations.of(context)!.dialogInformationContentBridgeDeparture(isWineFestivalSailBoats ? 2 : 1)} ',
              ),
              toLocalizedTextSpan(context, colored),
            ],
          )
        : TextSpan(
            children: [
              TextSpan(
                text:
                    '${AppLocalizations.of(context)!.dialogInformationContentBridgeArrival(isWineFestivalSailBoats ? 2 : 1)} ',
              ),
              toLocalizedTextSpan(context, colored),
            ],
          );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'is_living': isLeaving,
    };
  }

  @override
  List<Object?> get props => [name, isLeaving];
}
