import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChabanBridgeStatusWidget extends StatelessWidget {
  final ChabanBridgeStatus bridgeStatus;

  const ChabanBridgeStatusWidget({Key? key, required this.bridgeStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bridgeStatus.getBackgroundColor(),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  CustomProperties.borderRadius,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bridgeStatus.currentStatus,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  bridgeStatus.currentStatusShort.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                bridgeStatus.nextStatusMessagePrefix,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                bridgeStatus.remainingTime,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Flexible(
            child: ChabanBridgeForecastListItem(
              chabanBridgeForecast: bridgeStatus.nextChabanBridgeForecast,
              index: -1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.lisOfUpcomingClosures,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Icon(Icons.arrow_circle_down),
            ],
          ),
        ],
      ),
    );
  }
}
