import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/widgets/information_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChabanBridgeForecastListItem extends StatelessWidget {
  final AbstractChabanBridgeForecast chabanBridgeForecast;
  final Function()? onTap;
  final bool hasPassed;
  final bool isCurrent;
  final int index;

  const ChabanBridgeForecastListItem(
      {Key? key,
      required this.chabanBridgeForecast,
      required this.index,
      required this.hasPassed,
      required this.isCurrent,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: isCurrent
              ? RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                  side: BorderSide(
                    // border color
                    color: chabanBridgeForecast.color,
                    // border thickness
                    width: 2,
                  ),
                )
              : null,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
            onTap: onTap ??
                () => {
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
                child: chabanBridgeForecast.getIconWidget(null),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.block_rounded,
                                size: 20, color: Colors.red),
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
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
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
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.check_circle,
                                size: 20, color: Colors.green),
                            Text(
                              chabanBridgeForecast
                                  .circulationReOpeningDateString(
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
                  ),
                ],
              ),
            ),
          ),
        ),
        if (hasPassed)
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: CustomProperties.blurSigmaX,
                    sigmaY: CustomProperties.blurSigmaY),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.passedClosure,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
