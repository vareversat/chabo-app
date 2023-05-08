import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChabanBridgeForecastInformationDialog extends StatelessWidget {
  final AbstractChabanBridgeForecast chabanBridgeForecast;

  const ChabanBridgeForecastInformationDialog({
    super.key,
    required this.chabanBridgeForecast,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        20,
        10,
      ),
      title: Container(
        decoration: BoxDecoration(
          color: chabanBridgeForecast.getColor(context, false),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              15.0,
            ),
            topRight: Radius.circular(
              15.0,
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          0,
          15,
        ),
        child: Row(
          children: [
            chabanBridgeForecast.getIconWidget(context, true),
            const SizedBox(width: 20),
            Text(
              AppLocalizations.of(context)!.information,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: chabanBridgeForecast.getInformationWidget(context),
          ),
          if (chabanBridgeForecast.interferingTimeSlots.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.warningColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    15.0,
                  ),
                  bottomRight: Radius.circular(
                    15.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!
                          .favoriteSlotsInterferenceWarning,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
