import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:chabo/widgets/forecast_information_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      await showModalBottomSheet(
                        useSafeArea: false,
                        barrierColor: Colors.black.withOpacity(0.65),
                        constraints: BoxConstraints(
                          maxWidth: DeviceHelper.isPortrait(context)
                              ? double.infinity
                              : MediaQuery.of(context).size.width / 2.5,
                        ),
                        enableDrag: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              CustomProperties.borderRadius * 2,
                            ),
                          ),
                        ),
                        builder: (context) {
                          return ForecastInformationBottomSheet(
                            forecast: forecast,
                          );
                        },
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
