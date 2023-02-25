import 'package:chabo/bloc/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/const.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/screens/settings_screen.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list.dart';
import 'package:chabo/widgets/chaban_bridge_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChabanBridgeForecastScreen extends StatefulWidget {
  const ChabanBridgeForecastScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChabanBridgeForecastScreenState();
  }
}

class _ChabanBridgeForecastScreenState
    extends CustomWidgetState<ChabanBridgeForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Const.appName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          );
        },
        heroTag: 'settingsButtonIcon',
        child: const Icon(Icons.settings),
      ),
      body: BlocProvider(
        create: (_) => ChabanBridgeForecastBloc(httpClient: http.Client())
          ..add(ChabanBridgeForecastFetched()),
        child: BlocBuilder<ChabanBridgeForecastBloc, ChabanBridgeForecastState>(
          builder: (context, state) {
            switch (state.status) {
              case ChabanBridgeForecastStatus.failure:
                return ErrorScreen(errorMessage: state.message);
              case ChabanBridgeForecastStatus.success:
                if (state.chabanBridgeForecasts.isEmpty) {
                  return const ErrorScreen(errorMessage: 'Empty return');
                }
                var bridgeStatus = ChabanBridgeStatus(
                    nextChabanBridgeForecast:
                        state.chabanBridgeForecasts.getNext(),
                    context: context);
                return Column(
                  children: [
                    Flexible(
                      flex: 9,
                      child: ChabanBridgeStatusWidget(
                        bridgeStatus: bridgeStatus,
                      ),
                    ),
                    Flexible(
                      flex: 7,
                      child: ChabanBridgeForecastList(
                        chabanBridgeForecasts:
                            state.chabanBridgeForecasts.getFollowings(),
                        hasReachedMax: state.hasReachedMax,
                      ),
                    ),
                  ],
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
