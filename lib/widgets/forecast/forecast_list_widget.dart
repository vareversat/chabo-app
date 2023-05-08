import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/bloc/time_slot/time_slot_bloc.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/widgets/ad_banner_widget.dart';
import 'package:chabo/widgets/forecast/forecast_list_item_widget.dart';
import 'package:flutter/foundation.dart';
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
      child: BlocBuilder<ChabanBridgeForecastBloc, ChabanBridgeForecastState>(
        builder: (context, forecastState) {
          return BlocBuilder<TimeSlotBloc, TimeSlotState>(
            builder: (context, timeSlotState) {
              return ListView.separated(
                cacheExtent: 5000,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  forecastState.chabanBridgeForecasts[index]
                      .checkSlotInterference(timeSlotState.timeSlots);

                  return ForecastListItemWidget(
                    key: GlobalObjectKey(
                      forecastState.chabanBridgeForecasts[index].hashCode,
                    ),
                    isCurrent: forecastState.chabanBridgeForecasts[index] ==
                        forecastState.currentChabanBridgeForecast,
                    hasPassed: forecastState
                        .chabanBridgeForecasts[index].circulationReOpeningDate
                        .isBefore(DateTime.now()),
                    chabanBridgeForecast:
                        forecastState.chabanBridgeForecasts[index],
                    index: index,
                    timeSlots: forecastState
                        .chabanBridgeForecasts[index].interferingTimeSlots,
                  );
                },
                itemCount: forecastState.chabanBridgeForecasts.length,
                controller:
                    BlocProvider.of<ScrollStatusBloc>(context).scrollController,
                separatorBuilder: (BuildContext context, int index) {
                  if ((index + 1 <=
                          forecastState.chabanBridgeForecasts.length &&
                      forecastState.chabanBridgeForecasts[index]
                              .circulationClosingDate.month !=
                          forecastState.chabanBridgeForecasts[index + 1]
                              .circulationClosingDate.month)) {
                    return _MonthWidget(
                      chabanBridgeForecast:
                          forecastState.chabanBridgeForecasts[index + 1],
                    );
                  }
                  if (((index % 10 == 0 ||
                              index ==
                                  forecastState.chabanBridgeForecasts.indexOf(
                                    forecastState.currentChabanBridgeForecast!,
                                  )) &&
                          index != 0) &&
                      !kIsWeb) {
                    return const AdBannerWidget();
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
  final AbstractChabanBridgeForecast chabanBridgeForecast;

  const _MonthWidget({Key? key, required this.chabanBridgeForecast})
      : super(key: key);

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
                  chabanBridgeForecast.circulationClosingDate,
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
