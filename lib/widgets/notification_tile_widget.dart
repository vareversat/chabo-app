import 'package:chabo/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: const ValueKey('notificationButton'),
      title: Text(
        AppLocalizations.of(context)!.notifications,
        style: const TextStyle(fontSize: 25),
      ),
      subtitle: Text(
        AppLocalizations.of(context)!.notificationsSubtitle,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      selected: true,
      leading: const Icon(
        Icons.notifications_active_outlined,
        size: 30,
      ),
      onTap: () async => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const NotificationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(
                curve: curve,
              ),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
