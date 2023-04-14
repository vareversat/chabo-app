import 'dart:async';

import 'package:chabo/bloc/chaban_bridge_status/chaban_bridge_status_bloc.dart';
import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChabanBridgeStatusWidget extends StatefulWidget {
  const ChabanBridgeStatusWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChabanBridgeStatusWidgetState();
  }
}

class ChabanBridgeStatusWidgetState
    extends CustomWidgetState<ChabanBridgeStatusWidget> {
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: state.backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      CustomProperties.borderRadius,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.mainMessageStatus,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: state.foregroundColor,
                      ),
                    ),
                  ],
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
                  Text(
                    state.durationUntilNextEvent.durationToString(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
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
                        child: LinearProgressIndicator(
                          value: state.completionPercentage,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            state.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      reverseDuration: const Duration(milliseconds: 200),
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
                              child: ChabanBridgeForecastListItem(
                                onTap: () =>
                                    BlocProvider.of<ScrollStatusBloc>(context)
                                        .add(
                                  GoTo(
                                    goTo: state.currentTarget,
                                  ),
                                ),
                                hasPassed: false,
                                isCurrent: true,
                                chabanBridgeForecast: state.currentTarget!,
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
                    AppLocalizations.of(context)!.lisOfUpcomingClosures,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Icon(Icons.arrow_circle_down),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
