import 'package:chabo/bloc/forecast/forecast_bloc.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/bloc/status/status_bloc.dart';
import 'package:chabo/cubits/floating_actions_cubit.dart';
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

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForecastScreenState();
  }
}

class _ForecastScreenState extends CustomWidgetState<ForecastScreen> {
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
            child: BlocBuilder<ForecastBloc, ForecastState>(
              buildWhen: (previous, current) =>
                  previous.status == ForecastStatus.initial &&
                  current.status == ForecastStatus.success,
              builder: (context, state) {
                switch (state.status) {
                  case ForecastStatus.failure:
                    return ErrorScreen(errorMessage: state.message);
                  case ForecastStatus.success:
                    if (state.forecasts.isEmpty) {
                      return const ErrorScreen(errorMessage: 'Empty return');
                    }

                    return MultiBlocListener(
                      listeners: [
                        BlocListener<ForecastBloc, ForecastState>(
                          listener: (context, state) {
                            BlocProvider.of<StatusBloc>(context).add(
                              StatusChanged(
                                currentForecast: state.currentForecast,
                                previousForecast: state.previousForecast,
                              ),
                            );
                            BlocProvider.of<ScrollStatusBloc>(context).add(
                              GoTo(goTo: state.currentForecast),
                            );
                          },
                        ),
                        BlocListener<NotificationBloc, NotificationState>(
                          listener: (context, state) {
                            BlocProvider.of<StatusBloc>(context).add(
                              StatusDurationChanged(
                                duration: state.durationNotificationValue,
                              ),
                            );
                            BlocProvider.of<NotificationBloc>(context).add(
                              ComputeNotificationEvent(
                                forecasts: BlocProvider.of<ForecastBloc>(
                                  context,
                                ).state.forecasts,
                                context: context,
                              ),
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
