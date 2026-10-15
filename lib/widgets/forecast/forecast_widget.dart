import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/extensions/date_time_extension.dart';
import 'package:chabo_app/extensions/duration_extension.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/models/time_slot.dart';
import 'package:chabo_app/widgets/bottom_sheets/forecast_information_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ForecastWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final Function()? onTap;
  final bool hasPassed;
  final List<TimeSlot> timeSlots;
  final bool isCurrent;
  final int index;
  final Color? borderColor;

  const ForecastWidget({
    super.key,
    required this.forecast,
    required this.index,
    required this.hasPassed,
    required this.isCurrent,
    this.onTap,
    required this.timeSlots,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final local = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                CustomProperties.borderRadius,
              ),
              side: isCurrent
                  ? BorderSide(
                      width: 4,
                      color: borderColor ?? forecast.getColor(context, false),
                    )
                  : timeSlots.isNotEmpty
                  ? BorderSide(
                      width: 4,
                      color: Theme.of(context).colorScheme.warningColor,
                    )
                  : BorderSide(
                      width: 2,
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                    ),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
            const EdgeInsets.symmetric(horizontal: 0),
          ),
        ),
        onPressed:
            onTap ??
            () async => {
              await showModalBottomSheet(
                isScrollControlled: true,
                barrierColor: Colors.black.withValues(alpha: 0.65),
                context: context,
                builder: (context) {
                  return ForecastInformationBottomSheet(forecast: forecast);
                },
              ),
            },
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 5,
              child: Opacity(
                opacity: 0.35,
                child: forecast.getIconWidget(context, false, 75, false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forecast.circulationClosingDate.day ==
                            forecast.circulationReOpeningDate.day
                        ? DateFormat.MMMMEEEEd(local)
                              .format(forecast.circulationClosingDate)
                        : '${DateFormat.MMMEd(local).format(forecast.circulationClosingDate)} / '
                              '${DateFormat.MMMEd(local).format(forecast.circulationReOpeningDate)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 6.0),
                  BlocBuilder<TimeFormatCubit, TimeFormatState>(
                    builder: (context, state) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: forecast.circulationClosingDate
                                .toLocalizedTextSpan(
                                  context,
                                  Theme.of(context).textTheme.headlineSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                          ),
                          SizedBox(width: 10),
                          RichText(
                            text: forecast.circulationReOpeningDate
                                .toLocalizedTextSpan(
                                  context,
                                  Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${AppLocalizations.of(context)!.duration}: ${forecast.closedDuration.durationToString(context)}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
