import 'package:chabo/bloc/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';
import 'package:chabo/widgets/bottom_loader_widget.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChabanBridgeForecastList extends StatefulWidget {
  final List<AbstractChabanBridgeForecast> chabanBridgeForecasts;
  final bool hasReachedMax;

  const ChabanBridgeForecastList(
      {Key? key,
      required this.chabanBridgeForecasts,
      required this.hasReachedMax})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChabanBridgeForecastListState();
  }
}

class _ChabanBridgeForecastListState extends State<ChabanBridgeForecastList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (BuildContext context, int index) {
        return index >= widget.chabanBridgeForecasts.length
            ? const BottomLoaderWidget()
            : ChabanBridgeForecastListItem(
                chabanBridgeForecast: widget.chabanBridgeForecasts[index],
                index: index);
      },
      itemCount: widget.hasReachedMax
          ? widget.chabanBridgeForecasts.length
          : widget.chabanBridgeForecasts.length + 1,
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<ChabanBridgeForecastBloc>()
          .add(ChabanBridgeForecastFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
