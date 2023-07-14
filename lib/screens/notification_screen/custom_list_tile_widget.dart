part of 'notification_screen.dart';

class _CustomListTileWidget extends StatelessWidget {
  final bool enabled;
  final bool constrainedBySlots;
  final Function()? onTap;
  final Function(bool) onChanged;
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Color? iconColor;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>((states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }

    return const Icon(Icons.close);
  });

  _CustomListTileWidget({
    Key? key,
    required this.enabled,
    this.onTap,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.onChanged,
    required this.constrainedBySlots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: CustomProperties.animationDurationMs,
              ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity:
                      CurvedAnimation(parent: animation, curve: Curves.easeIn),
                  child: SlideTransition(
                    position: Tween(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: constrainedBySlots && enabled
                  ? CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          Theme.of(context).colorScheme.warningColor,
                      child: Container(),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
      subtitle: Text(subtitle),
      leading: Icon(
        leadingIcon,
      ),
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          onTap != null
              ? const VerticalDivider(
                  width: 20,
                )
              : const SizedBox.shrink(),
          Switch.adaptive(
            thumbIcon: thumbIcon,
            value: enabled,
            onChanged: (value) {
              Sentry.addBreadcrumb(
                Breadcrumb(
                  message: 'Change "$title" state',
                  level: SentryLevel.info,
                  category: 'notification.change-state',
                  type: 'Notification',
                  data: {
                    'old-state': !value,
                    'new-state': value,
                  },
                ),
              );
              onChanged(value);
            },
          ),
        ],
      ),
      iconColor: iconColor ?? Theme.of(context).colorScheme.primary,
      enabled: enabled,
    );
  }
}
