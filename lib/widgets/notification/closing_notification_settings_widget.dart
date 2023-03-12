import 'package:chabo/bloc/closing_notification/closing_notification_bloc.dart';
import 'package:chabo/widgets/notification/notification_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClosingNotificationSettingsWidget extends NotificationSettingsWidget {
  const ClosingNotificationSettingsWidget(
      {required String title,
      required bool enabled,
      required String subtitle,
      Key? key})
      : super(key: key, title: title, enabled: enabled, subtitle: subtitle);

  @override
  void onEnablePressed(bool value, BuildContext context) {
    BlocProvider.of<ClosingNotificationBloc>(context).add(
      ClosingNotificationChanged(
        enabled: value,
      ),
    );
  }

  @override
  void onEditPressed(BuildContext context) {
    throw UnimplementedError();
  }
}
