import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationDialog extends StatelessWidget {
  final String heroTag;
  final AbstractChabanBridgeForecast chabanBridgeForecast;

  const InformationDialog(
      {super.key, required this.chabanBridgeForecast, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(20),
        actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
        title: Container(
          decoration: BoxDecoration(
              color: chabanBridgeForecast.color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 15),
          child: Row(
            children: [
              Hero(
                tag: heroTag,
                child: Icon(
                  chabanBridgeForecast.icon,
                  color: Theme.of(context).cardColor,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                AppLocalizations.of(context)!.information,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).cardColor),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: chabanBridgeForecast.getInformationWidget(context));
  }
}
