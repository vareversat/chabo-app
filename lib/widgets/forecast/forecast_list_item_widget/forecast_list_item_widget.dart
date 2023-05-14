import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/forecast_information_dialog.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'closing_info_widget.dart';

part 'duration_widget.dart';

part 'leading_icon_widget.dart';

part 'opening_info_widget.dart';

part 'time_slot_warning_widget.dart';

class ForecastListItemWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final Function()? onTap;
  final bool hasPassed;
  final List<TimeSlot> timeSlots;
  final bool isCurrent;
  final int index;
  final Color? backgroundColor;

  const ForecastListItemWidget({
    Key? key,
    required this.forecast,
    required this.index,
    required this.hasPassed,
    required this.isCurrent,
    this.onTap,
    required this.timeSlots,
    this.backgroundColor,
  }) : super(key: key);

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
                          color: backgroundColor ??
                              forecast.getColor(context, false),
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
                                sigmaY: CustomProperties.blurSigmaY,
                              ),
                              child: ForecastInformationDialog(
                                forecast: forecast,
                              ),
                            ),
                          );
                        },
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        transitionDuration: const Duration(
                          milliseconds: 300,
                        ),
                      ),
                    },
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _LeadingIconWidget(
                    forecast: forecast,
                    backgroundColor: backgroundColor ??
                        forecast.getColor(
                          context,
                          false,
                        ),
                  ),
                  Flexible(
                    flex: 2,
                    child: _ClosingInfoWidget(
                      forecast: forecast,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: _DurationWidget(
                      forecast: forecast,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: _OpeningInfoWidget(
                      forecast: forecast,
                    ),
                  ),
                  timeSlots.isNotEmpty
                      ? const _TimeSlotWarningWidget()
                      : Container(
                          width: 15,
                        ),
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
                    sigmaY: CustomProperties.blurSigmaY,
                  ),
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
