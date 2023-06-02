import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/forecast_information_dialog.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

part 'closing_info_widget.dart';

part 'day_widget.dart';

part 'duration_widget.dart';

part 'leading_icon_widget.dart';

part 'opening_info_widget.dart';

part 'time_slot_warning_widget.dart';

class ForecastWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final Function()? onTap;
  final bool hasPassed;
  final List<TimeSlot> timeSlots;
  final bool isCurrent;
  final int index;
  final Color? backgroundColor;

  const ForecastWidget({
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
                      : BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
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
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: _LeadingIconWidget(
                      forecast: forecast,
                      backgroundColor: backgroundColor ??
                          forecast.getColor(
                            context,
                            false,
                          ),
                    ),
                  ),
                  Flexible(
                    flex: 12,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Center(
                                child: _DayWidget(
                                  forecast: forecast,
                                ),
                              ),
                              timeSlots.isNotEmpty
                                  ? const _TimeSlotWarningWidget()
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: _ClosingInfoWidget(
                                    forecast: forecast,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: _OpeningInfoWidget(
                                    forecast: forecast,
                                  ),
                                ),
                              ],
                            ),
                            _DurationWidget(
                              forecast: forecast,
                            ),
                          ],
                        ),
                      ],
                    ),
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
