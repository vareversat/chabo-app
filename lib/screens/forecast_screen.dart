import 'package:chabo/bloc/forecast/forecast_bloc.dart';
import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/bloc/status/status_bloc.dart';
import 'package:chabo/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo/cubits/floating_actions_cubit.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widget_state.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/misc/no_scaling_animation.dart';
import 'package:chabo/screens/error_screen.dart';
import 'package:chabo/widgets/ad_banner_widget.dart';
import 'package:chabo/widgets/floating_actions/floating_actions_widget.dart';
import 'package:chabo/widgets/forecast/forecast_list_widget.dart';
import 'package:chabo/widgets/forecast/status_widget/status_widget.dart';
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
          floatingActionButton: Column(
            crossAxisAlignment: state.isRightHanded
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: FloatingActionsWidget(),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: state.isRightHanded ? 32 : 0,
                      right: state.isRightHanded ? 0 : 32,
                      top: 5,
                    ),
                    child: const AdBannerWidget(),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButtonLocation: state.isRightHanded
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.startFloat,
          floatingActionButtonAnimator: NoScalingAnimation(),
          body: SafeArea(
            top: false,
            child: BlocBuilder<ForecastBloc, ForecastState>(
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
                        child: BlocBuilder<ScrollStatusBloc, ScrollStatusState>(
                          builder: (context, state) {
                            return DeviceHelper.isPortrait(context)
                                ? CustomScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    slivers: [
                                      SliverAppBar(
                                        pinned: true,
                                        snap: false,
                                        stretch: true,
                                        collapsedHeight: 250,
                                        expandedHeight: 250,
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
                                        flex: !DeviceHelper.isMobile(context)
                                            ? 2
                                            : 1,
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
                                                    CustomProperties
                                                            .borderRadius *
                                                        2,
                                                  ),
                                                ),
                                              ),
                                              constraints: BoxConstraints(
                                                minHeight:
                                                    DeviceHelper.isMobile(
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
                                      const Flexible(
                                        child: CustomScrollView(
                                          physics: BouncingScrollPhysics(),
                                          slivers: [
                                            ForecastListWidget(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                          },
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
