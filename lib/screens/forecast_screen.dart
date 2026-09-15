import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:chabo_app/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/screens/error_screen.dart';
import 'package:chabo_app/widgets/chabo_app_bar/chabo_app_bar.dart';
import 'package:chabo_app/widgets/forecast/forecast_list_widget.dart';
import 'package:chabo_app/widgets/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastScreen extends StatefulWidget {
  static const routeName = '/forecast-screen';

  const ForecastScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForecastScreenState();
  }
}

class _ForecastScreenState extends CustomWidgetState<ForecastScreen> {
  _ForecastScreenState() : super(screenName: 'forecast-screen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChaboAppBar(),
      body: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, forecastState) {
          switch (forecastState.status) {
            case ForecastStatus.failure:
              return ErrorScreen(errorMessage: forecastState.message);
            case ForecastStatus.success:
              if (forecastState.forecasts.isEmpty) {
                return const ErrorScreen(errorMessage: 'Empty return');
              }

              return MultiBlocListener(
                listeners: [
                  BlocListener<ForecastBloc, ForecastState>(
                    listener: (context, state) {
                      /// If the ForecastState changes, update the previous and current forecasts
                      BlocProvider.of<StatusBloc>(context).add(
                        StatusChanged(
                          currentForecast: state.currentForecast,
                          previousForecast: state.previousForecast,
                        ),
                      );
                    },
                  ),
                  BlocListener<NotificationBloc, NotificationState>(
                    listener: (context, state) {
                      /// If the NotificationState changes, update the durationNotificationValue
                      /// to get the right color of the current status widget
                      BlocProvider.of<StatusBloc>(context).add(
                        StatusDurationChanged(
                          isEnabled: state.durationNotificationEnabled,
                          duration: state.durationNotificationValue,
                        ),
                      );

                      /// And compute all notifications
                      BlocProvider.of<NotificationBloc>(context).add(
                        ComputeNotificationEvent(
                          forecasts: BlocProvider.of<ForecastBloc>(context)
                              .state
                              .forecasts,
                          context: context,
                          timeSlotsState: BlocProvider.of<TimeSlotsBloc>(
                            context,
                          ).state,
                        ),
                      );
                    },
                  ),
                  BlocListener<TimeSlotsBloc, TimeSlotsState>(
                    listener: (context, state) {
                      /// If the TimeSlotsState changes and the timeSlotsEnabledForNotifications is enabled,
                      /// re-compute all notifications
                      if (BlocProvider.of<NotificationBloc>(context)
                          .state
                          .timeSlotsEnabledForNotifications) {
                        BlocProvider.of<NotificationBloc>(context).add(
                          ComputeNotificationEvent(
                            forecasts: BlocProvider.of<ForecastBloc>(context)
                                .state
                                .forecasts,
                            context: context,
                            timeSlotsState: BlocProvider.of<TimeSlotsBloc>(
                              context,
                            ).state,
                          ),
                        );
                      }
                    },
                  ),
                  BlocListener<TimeFormatCubit, TimeFormatState>(
                    listener: (context, state) {
                      /// If the TimeFormatState changes, re compute all notifications
                      BlocProvider.of<NotificationBloc>(context).add(
                        ComputeNotificationEvent(
                          forecasts: BlocProvider.of<ForecastBloc>(context)
                              .state
                              .forecasts,
                          context: context,
                          timeSlotsState: BlocProvider.of<TimeSlotsBloc>(
                            context,
                          ).state,
                        ),
                      );
                    },
                  ),
                  BlocListener<StatusBloc, StatusState>(
                    listener: (context, state) {
                      /// If the state of the bridge changes, needs to get the correct image
                      BlocProvider.of<ThemeBloc>(
                        context,
                      ).add(BridgeStateChanged(bridgeState: state.bridgeState));
                    },
                  ),
                ],
                child: const ForecastListWidget(),
              );
            default:
              return CustomCircularProgressIndicator(
                message: AppLocalizations.of(context)!.loading,
              );
          }
        },
      ),
    );
  }
}
