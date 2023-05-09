import 'package:chabo/bloc/forecast/forecast_bloc.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/widgets/forecast/forecast_list_item_widget.dart';
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
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          BlocProvider.of<ScrollStatusBloc>(context).add(
            ScrollStatusChanged(),
          );
        }

        return true;
      },
      child: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, forecastState) {
          return BlocBuilder<NotificationBloc, NotificationState>(
            buildWhen: (previous, next) =>
                previous.timeSlotsValue != next.timeSlotsValue,
            builder: (context, timeSlotState) {
              return ListView.separated(
                cacheExtent: 5000,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  forecastState.forecasts[index]
                      .computeSlotInterference(timeSlotState.timeSlotsValue);

                  return ForecastListItemWidget(
                    key: GlobalObjectKey(
                      forecastState.forecasts[index].hashCode,
                    ),
                    isCurrent: forecastState.forecasts[index] ==
                        forecastState.currentForecast,
                    hasPassed: forecastState
                        .forecasts[index].circulationReOpeningDate
                        .isBefore(DateTime.now()),
                    forecast: forecastState.forecasts[index],
                    index: index,
                    timeSlots:
                        forecastState.forecasts[index].interferingTimeSlots,
                  );
                },
                itemCount: forecastState.forecasts.length,
                controller:
                    BlocProvider.of<ScrollStatusBloc>(context).scrollController,
                separatorBuilder: (BuildContext context, int index) {
                  if ((index + 1 <= forecastState.forecasts.length &&
                      forecastState
                              .forecasts[index].circulationClosingDate.month !=
                          forecastState.forecasts[index + 1]
                              .circulationClosingDate.month)) {
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
      ),
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
