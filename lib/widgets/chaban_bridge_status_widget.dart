import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:chabo/widgets/chaban_bridge_forecast_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChabanBridgeStatusWidget extends StatefulWidget {
  final ChabanBridgeStatus bridgeStatus;
  final bool showCurrentStatus;
  final Function()? onTap;

  const ChabanBridgeStatusWidget(
      {Key? key,
      required this.bridgeStatus,
      this.onTap,
      required this.showCurrentStatus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChabanBridgeStatusWidgetState();
  }
}

class ChabanBridgeStatusWidgetState
    extends CustomWidgetState<ChabanBridgeStatusWidget> {
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
            child: AnimatedSize(
              curve: Curves.ease,
              duration: const Duration(seconds: 1),
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                reverseDuration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: widget.showCurrentStatus
                    ? ChabanBridgeForecastListItem(
                        onTap: widget.onTap,
                        hasPassed: false,
                        isCurrent: true,
                        chabanBridgeForecast:
                            widget.bridgeStatus.currentChabanBridgeForecast,
                        index: -1,
                      )
                    : const SizedBox(),
              ),
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
