import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/widgets/information_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChabanBridgeForecastListItem extends StatelessWidget {
  const ChabanBridgeForecastListItem(
      {Key? key, required this.chabanBridgeForecast, required this.index})
      : super(key: key);

  final AbstractChabanBridgeForecast chabanBridgeForecast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              opaque: false,
              barrierDismissible: true,
              pageBuilder: (BuildContext context, _, __) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: CustomProperties.blurSigmaX,
                      sigmaY: CustomProperties.blurSigmaY),
                  child: InformationDialog(
                    chabanBridgeForecast: chabanBridgeForecast,
                    heroTag: "forcast-$index",
                  ),
                );
              },
            ),
          ),
        },
        child: ListTile(
          leading: Hero(
              tag: "forcast-$index",
              child: Icon(chabanBridgeForecast.icon,
                  color: chabanBridgeForecast.color)),
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child:
                    Icon(FontAwesomeIcons.bridgeCircleXmark, color: Colors.red),
              ),
              Text(chabanBridgeForecast.circulationClosingDateString(context)),
              const Text("\n"),
            ],
          ),
          subtitle: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(FontAwesomeIcons.bridgeCircleCheck,
                    color: Colors.green),
              ),
              Text(
                  chabanBridgeForecast.circulationReOpeningDateString(context)),
            ],
          ),
          trailing: Text(
            chabanBridgeForecast.durationString(),
            style: const TextStyle(
                color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
