import 'dart:ui';

import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/notification_dialog.dart';
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
      onTap: () async => await showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          return BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: CustomProperties.blurSigmaX,
                sigmaY: CustomProperties.blurSigmaY),
            child: const NotificationDialog(),
          );
        },
      ),
    );
  }
}
