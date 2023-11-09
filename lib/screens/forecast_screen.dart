import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo_app/cubits/floating_actions_cubit.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/misc/no_scaling_animation.dart';
import 'package:chabo_app/screens/error_screen.dart';
import 'package:chabo_app/widgets/floating_actions/floating_actions_widget.dart';
import 'package:chabo_app/widgets/forecast/forecast_list_widget.dart';
import 'package:chabo_app/widgets/forecast/status_widget/status_widget.dart';
import 'package:chabo_app/widgets/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return BlocBuilder<FloatingActionsCubit, FloatingActionsState>(
      builder: (context, floatingActionsState) {
        return Scaffold(
          floatingActionButton: const FloatingActionsWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: NoScalingAnimation(),
          body: SafeArea(
            top: false,
            child: BlocBuilder<ForecastBloc, ForecastState>(
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

                            /// And scroll to the new one
                            BlocProvider.of<ScrollStatusBloc>(context).add(
                              GoTo(goTo: state.currentForecast),
                            );
                          },
                        ),
                        BlocListener<NotificationBloc, NotificationState>(
                          listener: (context, state) {
                            /// If the NotificationState changes, update the durationNotificationValue
                            /// to get the right color of the current status widget
                            BlocProvider.of<StatusBloc>(context).add(
                              StatusDurationChanged(
                                duration: state.durationNotificationValue,
                              ),
                            );

                            /// And compute all notifications
                            BlocProvider.of<NotificationBloc>(context).add(
                              ComputeNotificationEvent(
                                forecasts: BlocProvider.of<ForecastBloc>(
                                  context,
                                ).state.forecasts,
                                context: context,
                                timeSlotsState:
                                    BlocProvider.of<TimeSlotsBloc>(context)
                                        .state,
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
                                  forecasts: BlocProvider.of<ForecastBloc>(
                                    context,
                                  ).state.forecasts,
                                  context: context,
                                  timeSlotsState:
                                      BlocProvider.of<TimeSlotsBloc>(context)
                                          .state,
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
                                forecasts: BlocProvider.of<ForecastBloc>(
                                  context,
                                ).state.forecasts,
                                context: context,
                                timeSlotsState:
                                    BlocProvider.of<TimeSlotsBloc>(context)
                                        .state,
                              ),
                            );
                          },
                        ),
                      ],
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is! UserScrollNotification) {
                            BlocProvider.of<ScrollStatusBloc>(context).add(
                              ScrollStatusChanged(),
                            );

                            /// Scroll reach the top and display the large layout for the status widget
                            if (scrollNotification.metrics.pixels <= 100) {
                              BlocProvider.of<StatusBloc>(context)
                                  .add(StatusWidgetDimensionChanged(
                                context: context,
                                dimension: StatusWidgetDimension.large,
                              ));
                            } else {
                              /// Else, display the small one
                              BlocProvider.of<StatusBloc>(context)
                                  .add(StatusWidgetDimensionChanged(
                                context: context,
                                dimension: StatusWidgetDimension.small,
                              ));
                            }
                          }

                          return true;
                        },
                        child: DeviceHelper.isPortrait(context)
                            ? CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: [
                                  SliverAppBar(
                                    pinned: true,
                                    snap: false,
                                    stretch: true,
                                    collapsedHeight: 200,
                                    expandedHeight: 200,
                                    shadowColor: Colors.black,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(
                                          CustomProperties.borderRadius * 2,
                                        ),
                                      ),
                                    ),
                                    flexibleSpace: const FlexibleSpaceBar(
                                      titlePadding: EdgeInsets.zero,
                                      centerTitle: true,
                                      expandedTitleScale: 1,
                                      title: StatusWidget(),
                                    ),
                                  ),
                                  const ForecastListWidget(),
                                ],
                              )
                            : Row(
                                children: [
                                  Flexible(
                                    flex:
                                        !DeviceHelper.isMobile(context) ? 3 : 1,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceVariant,
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              bottom: Radius.circular(
                                                CustomProperties.borderRadius *
                                                    2,
                                              ),
                                            ),
                                          ),
                                          constraints: BoxConstraints(
                                            minHeight: DeviceHelper.isMobile(
                                              context,
                                            )
                                                ? 270
                                                : 380,
                                          ),
                                          child: const StatusWidget(),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex:
                                        !DeviceHelper.isMobile(context) ? 2 : 1,
                                    child: const CustomScrollView(
                                      physics: BouncingScrollPhysics(),
                                      slivers: [
                                        ForecastListWidget(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
