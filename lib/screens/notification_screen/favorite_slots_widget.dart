part of 'notification_screen.dart';

class _FavoriteSlotsWidget extends StatefulWidget {
  final bool highlightTimeSlots;
  final bool timeSlotsEnabledForNotifications;

  const _FavoriteSlotsWidget({
    Key? key,
    required this.highlightTimeSlots,
    required this.timeSlotsEnabledForNotifications,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FavoriteSlotsWidgetState();
  }
}

class _FavoriteSlotsWidgetState extends State<_FavoriteSlotsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        _controller.stop();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = ColorTween(
      begin: Theme.of(context).colorScheme.primary,
      end: Theme.of(context).colorScheme.background,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInQuad,
      ),
    )..addListener(
        () {
          /// Trigger the rebuild of the widget
          // ignore: no-empty-block
          setState(() {});
        },
      );

    return BlocBuilder<TimeSlotsBloc, TimeSlotsState>(
      builder: (context, state) {
        return Column(
          children: [
            _CustomListTileWidget(
              onChanged: (bool value) => {
                BlocProvider.of<NotificationBloc>(context).add(
                  EnabledTimeSlotEvent(
                    enabled: value,
                  ),
                ),
                if (value)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 7),
                        showCloseIcon: true,
                        backgroundColor:
                            Theme.of(context).colorScheme.warningColor,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .favoriteTimeSlotEnabledWarning,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(
                      reason: SnackBarClosedReason.action,
                    ),
                  },
              },
              enabled: widget.timeSlotsEnabledForNotifications,
              title: AppLocalizations.of(context)!.favoriteSlots,
              subtitle: AppLocalizations.of(context)!.favoriteSlotsDescription,
              leadingIcon: Icons.warning_rounded,
              iconColor: Theme.of(context).colorScheme.warningColor,
              constrainedBySlots: false,
            ),
            Container(
              color: widget.highlightTimeSlots
                  ? _animation.value
                  : Colors.transparent,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < state.timeSlots.length; i++) ...[
                        TimeSlotWidget(
                          timeSlot: state.timeSlots[i],
                          index: i,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            CustomProperties.borderRadius,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: CustomProperties.blurSigmaX,
                              sigmaY: CustomProperties.blurSigmaY,
                            ),
                            child: const FavoriteSlotsDayPickerDialog(),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.calendar_view_week),
                    label: Text(
                      AppLocalizations.of(context)!.favoriteSlotsChooseDay,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
