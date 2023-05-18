part of 'status_widget.dart';

class _CurrentStatusWidget extends StatelessWidget {
  final StatusState statusState;

  const _CurrentStatusWidget({Key? key, required this.statusState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollStatusBloc, ScrollStatusState>(
      builder: (context, state) {
        return AnimatedSize(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: CustomProperties.animationDurationMs,
          ),
          reverseDuration: const Duration(milliseconds: 0),
          child: AnimatedSwitcher(
            duration: const Duration(
              seconds: 1,
            ),
            reverseDuration: const Duration(milliseconds: 0),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: state.showCurrentStatus &&
                    state.currentTarget != null &&
                    statusState.statusWidgetDimension ==
                        StatusWidgetDimension.small
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ForecastListItemWidget(
                      onTap: () => {
                        BlocProvider.of<ScrollStatusBloc>(
                          context,
                        ).add(
                          GoTo(
                            goTo: state.currentTarget,
                          ),
                        ),
                      },
                      hasPassed: false,
                      isCurrent: true,
                      forecast: state.currentTarget!,
                      index: -1,
                      timeSlots: const [],
                      backgroundColor: statusState.backgroundColor,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
