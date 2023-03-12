import 'package:chabo/bloc/opening_notification/opening_notification_bloc.dart';
import 'package:chabo/widgets/notification/notification_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpeningNotificationSettingsWidget extends NotificationSettingsWidget {
  const OpeningNotificationSettingsWidget(
      {required String title,
      required bool enabled,
      required String subtitle,
      Key? key})
      : super(key: key, title: title, enabled: enabled, subtitle: subtitle);

  @override
  void onEnablePressed(bool value, BuildContext context) {
    BlocProvider.of<OpeningNotificationBloc>(context).add(
      OpeningNotificationChanged(
        enabled: value,
      ),
    );
  }

  @override
  void onEditPressed(BuildContext context) {
    throw UnimplementedError();
  }
}
