part of 'status_widget.dart';

class _CurrentDockedBoatButton extends StatelessWidget {
  final StatusState statusState;

  const _CurrentDockedBoatButton({required this.statusState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
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

        /// Check if previousForecast is not null, if its a BoatForecast and that the string status is not empty
        child: statusState.statusWidgetDimension !=
                    StatusWidgetDimension.small &&
                statusState.previousForecast != null &&
                statusState.previousForecast is BoatForecast &&
                (statusState.previousForecast as BoatForecast)
                    .boats
                    .oneIsArriving()
            ? ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.boatColor,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).cardColor,
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        CustomProperties.borderRadius,
                      ),
                    ),
                  ),
                ),
                onPressed: () => {
                  showModalBottomSheet(
                    useSafeArea: false,
                    barrierColor: Colors.black.withOpacity(0.65),
                    constraints: BoxConstraints(
                      maxWidth: DeviceHelper.isPortrait(context)
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2.5,
                    ),
                    enableDrag: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          CustomProperties.borderRadius * 2,
                        ),
                      ),
                    ),
                    builder: (context) {
                      return CurrentDockedBoatBottomSheet(
                        statusState: statusState,
                      );
                    },
                  ),
                },
                icon: const Icon(Icons.info),
                label: Text(
                  AppLocalizations.of(context)!.moonHarborShortStatus(
                    (statusState.previousForecast as BoatForecast).boats.length,
                  ),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
