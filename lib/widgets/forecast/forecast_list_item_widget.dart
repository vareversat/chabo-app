import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/chaban_bridge_forecast_information_dialog.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForecastListItemWidget extends StatelessWidget {
  final AbstractChabanBridgeForecast chabanBridgeForecast;
  final Function()? onTap;
  final bool hasPassed;
  final bool isInterfering;
  final bool isCurrent;
  final int index;

  const ForecastListItemWidget(
      {Key? key,
      required this.chabanBridgeForecast,
      required this.index,
      required this.hasPassed,
      required this.isCurrent,
      this.onTap, required this.isInterfering})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(CustomProperties.borderRadius),
                  side: isCurrent
                      ? BorderSide(
                          width: 2,
                          color: chabanBridgeForecast.getColor(context, false),
                        )
                      : BorderSide.none,
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                const EdgeInsets.only(
                  right: 0,
                ),
              ),
            ),
            onPressed: onTap ??
                () async => {
                      await showGeneralDialog(
                        context: context,
                        pageBuilder: (BuildContext context, _, __) {
                          return const SizedBox.shrink();
                        },
                        barrierDismissible: true,
                        transitionBuilder: (context, a1, a2, widget) {
                          return FadeTransition(
                            opacity:
                                Tween<double>(begin: 0.0, end: 1.0).animate(a1),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: CustomProperties.blurSigmaX,
                                  sigmaY: CustomProperties.blurSigmaY),
                              child: ChabanBridgeForecastInformationDialog(
                                chabanBridgeForecast: chabanBridgeForecast,
                              ),
                            ),
                          );
                        },
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        transitionDuration: const Duration(
                          milliseconds: 300,
                        ),
                      )
                    },
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 65,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      color: chabanBridgeForecast.getColor(context, false),
                    ),
                    child: Center(child: chabanBridgeForecast.getIconWidget(context, true)),
                  ),

                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          MaterialLocalizations.of(context).formatMediumDate(
                            chabanBridgeForecast.circulationClosingDate,
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.block_rounded,
                                size: 20, color: Colors.red),
                            Text(
                              chabanBridgeForecast.circulationClosingDateString(
                                context,
                              ),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          chabanBridgeForecast.closedDuration
                              .durationToString(context),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.timeColor,
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
                        Text(
                          MaterialLocalizations.of(context).formatMediumDate(
                            chabanBridgeForecast.circulationReOpeningDate,
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
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
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            if (chabanBridgeForecast.isDuringTwoDays)
                              Text('(j +1)',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                 isInterfering ?
                  Container(
                    width: 30,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Theme.of(context).colorScheme.timeColor,
                    ),
                    child: Icon(
                      Icons.warning_rounded,
                      size: 20,
                      color: Theme.of(context).cardColor,
                    ),
                  ) : Container(width: 15,),
                ],
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
