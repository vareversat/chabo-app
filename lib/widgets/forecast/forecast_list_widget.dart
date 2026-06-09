import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/widgets/forecast/no_more_forecasts_widget.dart';
import 'package:chabo_app/widgets/forecast/forecast_widget.dart';
import 'package:chabo_app/widgets/wave_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ForecastListWidget extends StatefulWidget {
  const ForecastListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForecastListWidgetState();
  }
}

class _ForecastListWidgetState extends State<ForecastListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (context, forecastState) {
        return BlocBuilder<TimeSlotsBloc, TimeSlotsState>(
          builder: (context, timeSlotState) {
            // Check if the last forecast is before today
            if (forecastState.noMoreForecasts) {
              return const NoMoreForecastsWidget();
            }
            return ListView.separated(
              shrinkWrap: true,
              cacheExtent: 5000,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ).copyWith(bottom: 150),
              itemBuilder: (BuildContext context, int index) {
                final AbstractForecast forecast =
                    forecastState.forecasts[index];
                forecast.computeSlotInterference(timeSlotState);

                return !forecast.hasPassed()
                    ? ForecastWidget(
                        key: GlobalObjectKey(forecast.hashCode),
                        isCurrent: forecast == forecastState.currentForecast,
                        hasPassed: forecast.hasPassed(),
                        forecast: forecast,
                        index: index,
                        timeSlots: forecast.interferingTimeSlots,
                      )
                    : const SizedBox.shrink();
              },
              itemCount: forecastState.forecasts.length,
              separatorBuilder: (BuildContext context, int index) {
                final AbstractForecast forecast =
                    forecastState.forecasts[index];
                if ((forecast.circulationClosingDate.month !=
                            forecastState
                                .forecasts[index + 1]
                                .circulationClosingDate
                                .month) &&
                        !forecast.hasPassed() ||
                    forecastState.forecasts[index + 1] ==
                        forecastState.currentForecast) {
                  return _MonthWidget(
                    forecast: forecastState.forecasts[index + 1],
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }
}

class _MonthWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _MonthWidget({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: WaveDivider(height: 10)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            DateFormat.yMMMM(
              Localizations.localeOf(context).languageCode,
            ).format(forecast.circulationClosingDate),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(child: WaveDivider(height: 10)),
      ],
    );
  }
}
