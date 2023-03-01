import 'package:chabo/bloc/day_picker/day_picker_bloc.dart';
import 'package:chabo/bloc/duration_picker/duration_picker_bloc.dart';
import 'package:chabo/bloc/time_picker/time_picker_bloc.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/widgets/notification/day_notification_settings_widget.dart';
import 'package:chabo/widgets/notification/duration_notification_settings_widget.dart';
import 'package:chabo/widgets/notification/time_notification_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<DurationPickerBloc, DurationPickerState>(
              builder: (context, state) {
                return DurationNotificationSettingsWidget(
                  state: state,
                  enabled: state.enabled,
                  title:
                      AppLocalizations.of(context)!.durationNotificationTitle(
                    state.getDuration(),
                  ),
                  subtitle: AppLocalizations.of(context)!
                      .durationNotificationExplanation(
                    state.getDuration(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<TimePickerBloc, TimePickerState>(
              builder: (context, state) {
                return TimeNotificationSettingsWidget(
                  state: state,
                  enabled: state.enabled,
                  title: AppLocalizations.of(context)!
                      .timeNotificationTitle(state.getDuration()),
                  subtitle: AppLocalizations.of(context)!
                      .timeNotificationExplanation(state.getDuration()),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<DayPickerBloc, DayPickerState>(
              builder: (context, state) {
                return DayNotificationSettingsWidget(
                  state: state,
                  title: AppLocalizations.of(context)!.dayNotificationTitle(
                    state.day.localizedName(context),
                  ),
                  subtitle:
                      AppLocalizations.of(context)!.dayNotificationExplanation(
                    state.day.localizedName(context),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
