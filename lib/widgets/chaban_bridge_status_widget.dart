import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChabanBridgeStatusWidget extends StatefulWidget {
  final ChabanBridgeStatus bridgeStatus;

  const ChabanBridgeStatusWidget({Key? key, required this.bridgeStatus})
      : super(key: key);

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
        BlocProvider.of<ScrollStatusBloc>(context).add(
          GoTo(goTo: widget.bridgeStatus.currentChabanBridgeForecast),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.bridgeStatus.getBackgroundColor(context),
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
                  '${widget.bridgeStatus.currentStatus} ${widget.bridgeStatus.currentStatusShort}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: widget.bridgeStatus.getForegroundColor(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                widget.bridgeStatus.nextStatusMessagePrefix,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                widget.bridgeStatus.remainingTime,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
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
                    child: state.showCurrentStatus
                        ? ChabanBridgeForecastListItem(
                            onTap: () =>
                                BlocProvider.of<ScrollStatusBloc>(context).add(
                              GoTo(
                                goTo: widget
                                    .bridgeStatus.currentChabanBridgeForecast,
                              ),
                            ),
                            hasPassed: false,
                            isCurrent: true,
                            chabanBridgeForecast:
                                widget.bridgeStatus.currentChabanBridgeForecast,
                            index: -1,
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
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
        ],
      ),
    );
  }
}
