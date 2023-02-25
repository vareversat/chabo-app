import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/widgets/notification/notification_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DurationNotificationSettingsWidget extends NotificationSettingsWidget {
  final DurationPickerState state;

  const DurationNotificationSettingsWidget(
      {required this.state,
      required String title,
      required String subtitle,
      required bool enabled,
      Key? key})
      : super(
            key: key,
            title: title,
            subtitle: subtitle,
            enabled: enabled,
            iconData: Icons.calendar_month);

  @override
  void onEditPressed(BuildContext context) async {
    var time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: state.toTimeOfDay(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );
    if (time != null) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DurationPickerBloc>(context).add(
        DurationPickerChanged(
          duration: Duration(
            hours: time.hour,
            minutes: time.minute,
          ),
        ),
      );
    }
  }

  @override
  void onEnablePressed(bool value, BuildContext context) {
    BlocProvider.of<DurationPickerBloc>(context).add(
      DurationPickerStateChanged(
        enabled: value,
      ),
    );
  }
}
