import 'package:chabo/bloc/forecast/forecast_bloc.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/widgets/forecast/forecast_list_item_widget/forecast_list_item_widget.dart';
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
        return BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (previous, next) =>
              previous.timeSlotsValue != next.timeSlotsValue,
          builder: (context, timeSlotState) {
            return SliverToBoxAdapter(
              child: ListView.separated(
                shrinkWrap: true,
                cacheExtent: 5000,
                padding: const EdgeInsets.symmetric(horizontal: 5).copyWith(
                  bottom: 150,
                ),
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  final AbstractForecast forecast =
                      forecastState.forecasts[index];
                  forecast
                      .computeSlotInterference(timeSlotState.timeSlotsValue);

                  return !forecast.hasPassed()
                      ? ForecastListItemWidget(
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
                controller:
                    BlocProvider.of<ScrollStatusBloc>(context).scrollController,
                separatorBuilder: (BuildContext context, int index) {
                  final AbstractForecast forecast =
                      forecastState.forecasts[index];
                  if ((forecast.circulationClosingDate.month !=
                              forecastState.forecasts[index + 1]
                                  .circulationClosingDate.month) &&
                          !forecast.hasPassed() ||
                      forecastState.forecasts[index + 1] ==
                          forecastState.currentForecast) {
                    return _MonthWidget(
                      forecast: forecastState.forecasts[index + 1],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _MonthWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _MonthWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: Center(
              child: Text(
                DateFormat.MMMM(Localizations.localeOf(context).languageCode)
                    .format(
                  forecast.circulationClosingDate,
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
