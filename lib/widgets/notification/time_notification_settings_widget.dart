import 'package:chabo/bloc/time_picker/time_picker_bloc.dart';
import 'package:chabo/widgets/notification/notification_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeNotificationSettingsWidget extends NotificationSettingsWidget {
  final TimePickerState state;

  const TimeNotificationSettingsWidget(
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
      initialEntryMode: TimePickerEntryMode.dialOnly,
      context: context,
      initialTime: state.toTimeOfDay(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false,
          ),
          child: child!,
        );
      },
    );
    if (time != null) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<TimePickerBloc>(context).add(
        TimePickerChanged(
          time: Duration(
            hours: time.hour,
            minutes: time.minute,
          ),
        ),
      );
    }
  }

  @override
  void onEnablePressed(bool value, BuildContext context) {
    BlocProvider.of<TimePickerBloc>(context).add(
      TimePickerStateChanged(
        enabled: value,
      ),
    );
  }
}
