import 'package:chabo/bloc/chaban_bridge_forecast/chaban_bridge_forecast_bloc.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/notification_service_cubit.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/screens/settings_screen.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list.dart';
import 'package:chabo/widgets/chaban_bridge_status_widget.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const SettingsScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(
                    curve: curve,
                  ),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.settings),
      ),
      body: SafeArea(
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
                    currentChabanBridgeForecast:
                        state.currentChabanBridgeForecast!,
                    context: context);

                return MultiBlocListener(
                  listeners: [
                    BlocListener<NotificationBloc, NotificationSate>(
                      listener: (context, state) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    children: [
                      ChabanBridgeStatusWidget(
                        bridgeStatus: bridgeStatus,
                      ),
                      Expanded(
                        flex: 11,
                        child: ChabanBridgeForecastList(
                          currentChabanBridgeForecast:
                              state.currentChabanBridgeForecast,
                          chabanBridgeForecasts: state.chabanBridgeForecasts,
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
      ),
    );
  }
}
