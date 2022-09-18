import 'package:chabo/bloc/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/screens/settings_screen.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list.dart';
import 'package:chabo/widgets/chaban_bridge_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChabanBridgeForecastScreen extends StatelessWidget {
  const ChabanBridgeForecastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ));
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
                    lastChabanBridgeForecast:
                        state.chabanBridgeForecasts.getNext(),
                    context: context);
                return Container(
                  color: bridgeStatus.getBackgroundColor(),
                  child: Column(
                    children: [
                      Flexible(
                          flex: 2,
                          child: ChabanBridgeStatusWidget(
                              bridgeStatus: bridgeStatus)),
                      Flexible(
                          flex: 3,
                          child: ChabanBridgeForecastList(
                              chabanBridgeForecasts:
                                  state.chabanBridgeForecasts,
                              hasReachedMax: state.hasReachedMax)),
                    ],
                  ),
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
