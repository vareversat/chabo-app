import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/extensions/duration_extension.dart';
import 'package:chabo_app/widgets/progress_indicator/custom_progress_bar_indicator.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final StatusState statusState;

  const ProgressIndicatorWidget({super.key, required this.statusState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(
            milliseconds: CustomProperties.shortAnimationDurationMs,
          ),
          reverseDuration: const Duration(milliseconds: 0),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Text(
            statusState.timeMessagePrefix,
            style: Theme.of(context).textTheme.labelLarge!
                .copyWith(fontSize: 18),
          ),
        ),
        !statusState.durationUntilNextEvent.isNegative
            ? Text(
                statusState.durationUntilNextEvent.durationToString(context),
                style: Theme.of(context).textTheme.titleMedium!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              )
            : const SizedBox.shrink(),
        statusState.completionPercentage != -1
            ? SizedBox(
                height: 50,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(CustomProperties.borderRadius),
                  ),
                  child: CustomProgressBarIndicator(
                    max: 1,
                    current: statusState.completionPercentage,
                    color: statusState.backgroundColor,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
