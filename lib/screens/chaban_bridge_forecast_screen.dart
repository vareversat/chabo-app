import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/chaban_bridge_status/chaban_bridge_status_bloc.dart';
import 'package:chabo/bloc/floating_actions_cubit.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/notification_service_cubit.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/misc/no_scaling_animation.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list.dart';
import 'package:chabo/widgets/chaban_bridge_status_widget.dart';
import 'package:chabo/widgets/floating_actions_widget.dart';
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
                          listener: (context, state) async {
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
                        BlocListener<NotificationBloc, NotificationSate>(
                          listener: (context, state) async {
                            BlocProvider.of<ChabanBridgeStatusBloc>(context)
                                .add(
                              ChabanBridgeStatusDurationChanged(
                                duration: state.durationNotificationValue,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .refreshingNotifications,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            await context
                                .read<NotificationServiceCubit>()
                                .state
                                .computeNotifications(
                                    BlocProvider.of<ChabanBridgeForecastBloc>(
                                            context)
                                        .state
                                        .chabanBridgeForecasts,
                                    state,
                                    context);
                            ScaffoldMessenger.of(context).removeCurrentSnackBar(
                              reason: SnackBarClosedReason.remove,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Icon(
                                      Icons.check,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    )),
                                    Expanded(
                                      flex: 8,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .refreshingNotificationsDone,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                      child: Column(
                        children: const [
                          ChabanBridgeStatusWidget(),
                          Expanded(
                            flex: 11,
                            child: ChabanBridgeForecastList(),
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
          ),
        );
      },
    );
  }
}
