import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/chaban_bridge_forecast_information_dialog.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
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
                    color: chabanBridgeForecast.getColor(context, false),
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
            child: ListTile(
              horizontalTitleGap: 0,
              leading: chabanBridgeForecast.getIconWidget(context, false),
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
                          chabanBridgeForecast.closedDuration.durationToString(context),
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
