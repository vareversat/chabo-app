import 'dart:async';

import 'package:chabo/bloc/chaban_bridge_status/chaban_bridge_status_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/widgets/forecast/forecast_list_item_widget.dart';
import 'package:chabo/widgets/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:chabo/widgets/progress_indicator/custom_progress_bar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return StatusWidgetState();
  }
}

class StatusWidgetState extends CustomWidgetState<StatusWidget> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        Timer.periodic(
          const Duration(seconds: 1),
          (Timer t) => BlocProvider.of<ChabanBridgeStatusBloc>(context).add(
            ChabanBridgeStatusRefresh(
              context: context,
            ),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChabanBridgeStatusBloc, ChabanBridgeStatusState>(
      builder: (context, state) {
        return AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 800),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            reverseDuration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: state.chabanBridgeStatusLifecycle ==
                    ChabanBridgeStatusLifecycle.empty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 5),
                    child: CustomCircularProgressIndicator(
                      message: AppLocalizations.of(context)!.statusLoadMessage,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: state.backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                CustomProperties.borderRadius,
                              ),
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                            child: Text(
                              state.mainMessageStatus,
                              key: ValueKey<String>(state.mainMessageStatus),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: state.foregroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          children: [
                            Text(
                              state.timeMessagePrefix,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            !state.durationUntilNextEvent.isNegative
                                ? Text(
                                    state.durationUntilNextEvent
                                        .durationToString(context),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            state.completionPercentage != -1
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5),
                                    child: SizedBox(
                                      height: 10,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            CustomProperties.borderRadius,
                                          ),
                                        ),
                                        child: CustomProgressBarIndicator(
                                          max: 1,
                                          current: state.completionPercentage,
                                          color: state.backgroundColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Flexible(
                        child: BlocBuilder<ScrollStatusBloc, ScrollStatusState>(
                          builder: (context, state) {
                            return AnimatedSize(
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 800),
                              child: AnimatedSwitcher(
                                duration: const Duration(seconds: 1),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: state.showCurrentStatus &&
                                        state.currentTarget != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 15.0,
                                        ),
                                        child: ForecastListItemWidget(
                                          onTap: () =>
                                              BlocProvider.of<ScrollStatusBloc>(
                                                      context)
                                                  .add(
                                            GoTo(
                                              goTo: state.currentTarget,
                                            ),
                                          ),
                                          hasPassed: false,
                                          isCurrent: true,
                                          chabanBridgeForecast:
                                              state.currentTarget!,
                                          index: -1,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .lisOfUpcomingClosures,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Icon(Icons.arrow_circle_down),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
