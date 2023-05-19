part of 'notification_screen.dart';

class _FavoriteSlotsWidget extends StatefulWidget {
  final NotificationState notificationState;
  final bool highlightTimeSlots;

  const _FavoriteSlotsWidget({
    Key? key,
    required this.notificationState,
    required this.highlightTimeSlots,
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
          /// Trigger le rebuild of the widget
          // ignore: no-empty-block
          setState(() {});
        },
      );

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
                    backgroundColor: Theme.of(context).colorScheme.warningColor,
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
          enabled: widget.notificationState.timeSlotsEnabledForNotifications,
          title: AppLocalizations.of(context)!.favoriteSlots,
          subtitle: AppLocalizations.of(context)!.favoriteSlotsDescription,
          leadingIcon: Icons.warning_rounded,
          iconColor: Theme.of(context).colorScheme.warningColor,
          constrainedBySlots: false,
        ),
        Container(
          color:
              widget.highlightTimeSlots ? _animation.value : Colors.transparent,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0;
                  i < widget.notificationState.timeSlotsValue.length;
                  i++) ...[
                TimeSlotWidget(
                  timeSlot: widget.notificationState.timeSlotsValue[i],
                  index: i,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
