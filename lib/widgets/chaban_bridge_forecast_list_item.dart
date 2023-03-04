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
                    heroTag: 'forcast-$index',
                  ),
                );
              },
            ),
          ),
        },
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Hero(
            tag: 'forcast-$index',
            child: Icon(
              chabanBridgeForecast.icon,
              color: chabanBridgeForecast.color,
              size: 30,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.block_rounded,
                            size: 20, color: Colors.red),
                      ),
                      Text(
                        chabanBridgeForecast.circulationClosingDateString(
                          context,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    MaterialLocalizations.of(context).formatMediumDate(
                      chabanBridgeForecast.circulationClosingDate,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    chabanBridgeForecast.durationString(),
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Icon(
                    FontAwesomeIcons.arrowRightLong,
                    size: 20,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.check_circle,
                            size: 20, color: Colors.green),
                      ),
                      Text(
                        chabanBridgeForecast.circulationReOpeningDateString(
                          context,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    MaterialLocalizations.of(context).formatMediumDate(
                      chabanBridgeForecast.circulationReOpeningDate,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
