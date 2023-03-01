import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/bloc/time_picker/time_picker_bloc.dart';
import 'package:chabo/const.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/extensions/extensions.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/screens/settings_screen.dart';
import 'package:chabo/service/notification_service.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list.dart';
import 'package:chabo/widgets/chaban_bridge_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChabanBridgeForecastScreen extends StatefulWidget {
  final NotificationService notificationService;

  const ChabanBridgeForecastScreen(
      {Key? key, required this.notificationService})
      : super(key: key);

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
      body: BlocBuilder<ChabanBridgeForecastBloc, ChabanBridgeForecastState>(
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
              return MultiBlocListener(
                listeners: [
                  BlocListener<DurationPickerBloc, DurationPickerState>(
                      listener: (context, state) {
                    widget.notificationService
                        .computeDurationScheduledNotifications(
                            BlocProvider.of<ChabanBridgeForecastBloc>(context)
                                .state
                                .chabanBridgeForecasts,
                            state,
                            context);
                  }),
                  BlocListener<TimePickerBloc, TimePickerState>(
                      listener: (context, state) {
                    widget.notificationService
                        .computeTimeScheduledNotifications(
                            BlocProvider.of<ChabanBridgeForecastBloc>(context)
                                .state
                                .chabanBridgeForecasts,
                            state,
                            context);
                  })
                ],
                child: Column(
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
                ),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
