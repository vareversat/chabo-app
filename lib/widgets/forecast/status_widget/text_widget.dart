part of 'status_widget.dart';

class _TextWidget extends StatelessWidget {
  final StatusState statusState;

  const _TextWidget({
    Key? key,
    required this.statusState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
        decoration: BoxDecoration(
          color: statusState.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              CustomProperties.borderRadius,
            ),
          ),
        ),
        child: AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(
            milliseconds: CustomProperties.shortAnimationDurationMs,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: CustomProperties.shortAnimationDurationMs,
            ),
            reverseDuration: const Duration(
              milliseconds: 0,
            ),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              key: ValueKey<String>(
                statusState.statusWidgetDimension.toString(),
              ),
              statusState.mainMessageStatus,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: statusState.foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: DeviceHelper.isMobile(context)
                        ? 30
                        : DeviceHelper.isPortrait(context)
                            ? 30
                            : 55,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
