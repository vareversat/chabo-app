import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/widgets/bottom_loader_widget.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChabanBridgeForecastList extends StatefulWidget {
  final AbstractChabanBridgeForecast? currentChabanBridgeForecast;
  final List<AbstractChabanBridgeForecast> chabanBridgeForecasts;
  final ScrollController scrollController;
  final bool hasReachedMax;

  const ChabanBridgeForecastList(
      {Key? key,
      required this.chabanBridgeForecasts,
      required this.hasReachedMax,
      required this.currentChabanBridgeForecast,
      required this.scrollController})
      : super(key: key);

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
        if (scrollNotification is ScrollStartNotification) {
          BlocProvider.of<ScrollStatusBloc>(context).add(
            ScrollStatusChanged(type: ScrollStatusStateType.manual),
          );
        }
        return true;
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          return index >= widget.chabanBridgeForecasts.length
              ? const BottomLoaderWidget()
              : ChabanBridgeForecastListItem(
                  isCurrent: widget.chabanBridgeForecasts[index] ==
                      widget.currentChabanBridgeForecast,
                  hasPassed: widget
                      .chabanBridgeForecasts[index].circulationReOpeningDate
                      .isBefore(DateTime.now()),
                  chabanBridgeForecast: widget.chabanBridgeForecasts[index],
                  index: index);
        },
        itemCount: widget.hasReachedMax
            ? widget.chabanBridgeForecasts.length
            : widget.chabanBridgeForecasts.length + 1,
        controller: widget.scrollController,
      ),
    );
  }
}
