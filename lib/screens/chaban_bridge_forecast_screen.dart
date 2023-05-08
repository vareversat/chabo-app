import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/chaban_bridge_status/chaban_bridge_status_bloc.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/cubits/floating_actions_cubit.dart';
import 'package:chabo/cubits/notification_service_cubit.dart';
import 'package:chabo/custom_widget_state.dart';
import 'package:chabo/misc/no_scaling_animation.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/widgets/floating_actions/floating_actions_widget.dart';
import 'package:chabo/widgets/forecast/forecast_list_widget.dart';
import 'package:chabo/widgets/forecast/status_widget.dart';
import 'package:chabo/widgets/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return BlocBuilder<FloatingActionsCubit, FloatingActionsState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: const FloatingActionsWidget(),
          floatingActionButtonLocation: state.isRightHanded
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.startFloat,
          floatingActionButtonAnimator: NoScalingAnimation(),
          body: SafeArea(
            child: BlocBuilder<ChabanBridgeForecastBloc,
                ChabanBridgeForecastState>(
              buildWhen: (previous, current) =>
                  previous.status == ChabanBridgeForecastStatus.initial &&
                  current.status == ChabanBridgeForecastStatus.success,
              builder: (context, state) {
                switch (state.status) {
                  case ChabanBridgeForecastStatus.failure:
                    return ErrorScreen(errorMessage: state.message);
                  case ChabanBridgeForecastStatus.success:
                    if (state.chabanBridgeForecasts.isEmpty) {
                      return const ErrorScreen(errorMessage: 'Empty return');
                    }

                    return MultiBlocListener(
                      listeners: [
                        BlocListener<ChabanBridgeForecastBloc,
                            ChabanBridgeForecastState>(
                          listener: (context, state) {
                            BlocProvider.of<ChabanBridgeStatusBloc>(context)
                                .add(
                              ChabanBridgeStatusChanged(
                                currentChabanBridgeForecast:
                                    state.currentChabanBridgeForecast,
                                previousChabanBridgeForecast:
                                    state.previousChabanBridgeForecast,
                              ),
                            );
                            BlocProvider.of<ScrollStatusBloc>(context).add(
                              GoTo(goTo: state.currentChabanBridgeForecast),
                            );
                          },
                        ),
                        BlocListener<NotificationBloc, NotificationState>(
                          listener: (context, state) {
                            BlocProvider.of<ChabanBridgeStatusBloc>(context)
                                .add(
                              ChabanBridgeStatusDurationChanged(
                                duration: state.durationNotificationValue,
                              ),
                            );
                            context
                                .read<NotificationServiceCubit>()
                                .state
                                .computeNotifications(
                                  BlocProvider.of<ChabanBridgeForecastBloc>(
                                    context,
                                  ).state.chabanBridgeForecasts,
                                  state,
                                  context,
                                );
                          },
                        ),
                      ],
                      child: Column(
                        children: const [
                          StatusWidget(),
                          Expanded(
                            flex: 11,
                            child: ForecastListWidget(),
                          ),
                        ],
                      ),
                    );
                  default:
                    return CustomCircularProgressIndicator(
                      message: AppLocalizations.of(context)!.loading,
                    );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
