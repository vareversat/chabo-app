part of 'status_widget.dart';

class _ProgressIndicatorWidget extends StatelessWidget {
  final StatusState statusState;

  const _ProgressIndicatorWidget({required this.statusState});

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
          child:
              !(statusState.statusWidgetDimension ==
                  StatusWidgetDimension.small)
              ? Text(
                  statusState.timeMessagePrefix,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 18),
                )
              : const SizedBox.shrink(),
        ),
        !statusState.durationUntilNextEvent.isNegative
            ? Text(
                statusState.durationUntilNextEvent.durationToString(context),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox.shrink(),
        statusState.completionPercentage != -1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 10,
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
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
