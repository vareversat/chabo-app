import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'ad_banner_widget.dart';

class ChabanBridgeForecastList extends StatefulWidget {
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final List<AbstractChabanBridgeForecast> chabanBridgeForecasts;
  final bool hasReachedMax;

  const ChabanBridgeForecastList({
    Key? key,
    required this.chabanBridgeForecasts,
    required this.hasReachedMax,
    required this.currentChabanBridgeForecast,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChabanBridgeForecastListState();
  }
}

class _ChabanBridgeForecastListState extends State<ChabanBridgeForecastList> {
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
      child: ListView.separated(
        cacheExtent: 5000,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          return ChabanBridgeForecastListItem(
              key:
                  GlobalObjectKey(widget.chabanBridgeForecasts[index].hashCode),
              isCurrent: widget.chabanBridgeForecasts[index] ==
                  widget.currentChabanBridgeForecast,
              hasPassed: widget
                  .chabanBridgeForecasts[index].circulationReOpeningDate
                  .isBefore(DateTime.now()),
              chabanBridgeForecast: widget.chabanBridgeForecasts[index],
              index: index);
        },
        itemCount: widget.chabanBridgeForecasts.length,
        controller: BlocProvider.of<ScrollStatusBloc>(context).scrollController,
        separatorBuilder: (BuildContext context, int index) {
          if ((index + 1 <= widget.chabanBridgeForecasts.length &&
              widget.chabanBridgeForecasts[index].circulationClosingDate
                      .month !=
                  widget.chabanBridgeForecasts[index + 1].circulationClosingDate
                      .month)) {
            return _MonthWidget(
                chabanBridgeForecast: widget.chabanBridgeForecasts[index + 1]);
          }
          if ((index % 10 == 0 ||
                  index ==
                      widget.chabanBridgeForecasts
                          .indexOf(widget.currentChabanBridgeForecast!)) &&
              index != 0) {
            return const AdBannerWidget();
          }
          return const SizedBox.shrink();
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
