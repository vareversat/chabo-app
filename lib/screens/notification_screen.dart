import 'dart:ui';

import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/dialogs/days_of_the_week_dialog.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends CustomWidgetState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: const Icon(Icons.notifications_active_outlined),
        title: Text(
          AppLocalizations.of(context)!.notificationsTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: BlocBuilder<NotificationBloc, NotificationSate>(
          builder: (context, state) {
            return Column(
              children: [
                _CustomListTile(
                  onChanged: (bool value) =>
                      BlocProvider.of<NotificationBloc>(context).add(
                    OpeningNotificationStateEvent(
                      enabled: value,
                    ),
                  ),
                  enabled: state.openingNotificationEnabled,
                  title: AppLocalizations.of(context)!.openingNotificationTitle,
                  subtitle: AppLocalizations.of(context)!
                      .openingNotificationExplanation,
                  leadingIcon: Icons.check_circle,
                  iconColor: Colors.green,
                ),
                _CustomListTile(
                  onChanged: (bool value) =>
                      BlocProvider.of<NotificationBloc>(context).add(
                    ClosingNotificationStateEvent(
                      enabled: value,
                    ),
                  ),
                  enabled: state.closingNotificationEnabled,
                  title: AppLocalizations.of(context)!.closingNotificationTitle,
                  subtitle: AppLocalizations.of(context)!
                      .closingNotificationExplanation,
                  leadingIcon: Icons.block_rounded,
                  iconColor: Colors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                _CustomListTile(
                  onTap: () async {
                    var time = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.dialOnly,
                      context: context,
                      initialTime: state
                          .durationToTimeOfDay(state.durationNotificationValue),
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
                      BlocProvider.of<NotificationBloc>(context).add(
                        DurationNotificationValueEvent(
                          duration: Duration(
                            hours: time.hour,
                            minutes: time.minute,
                          ),
                        ),
                      );
                    }
                  },
                  onChanged: (bool value) =>
                      BlocProvider.of<NotificationBloc>(context).add(
                    DurationNotificationStateEvent(
                      enabled: value,
                    ),
                  ),
                  enabled: state.durationNotificationEnabled,
                  title:
                      AppLocalizations.of(context)!.durationNotificationTitle(
                    state.durationToString(state.durationNotificationValue),
                  ),
                  subtitle: AppLocalizations.of(context)!
                      .durationNotificationExplanation(
                    state.durationToString(state.durationNotificationValue),
                  ),
                  leadingIcon: Icons.timer_outlined,
                ),
                _CustomListTile(
                  onTap: () async {
                    var time = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.dialOnly,
                      context: context,
                      initialTime: state.timeNotificationValue,
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
                      BlocProvider.of<NotificationBloc>(context).add(
                        TimeNotificationValueEvent(
                          time: TimeOfDay(
                            hour: time.hour,
                            minute: time.minute,
                          ),
                        ),
                      );
                    }
                  },
                  onChanged: (bool value) =>
                      BlocProvider.of<NotificationBloc>(context).add(
                    TimeNotificationStateEvent(
                      enabled: value,
                    ),
                  ),
                  enabled: state.timeNotificationEnabled,
                  title: AppLocalizations.of(context)!.timeNotificationTitle(
                    state.timeNotificationValue.format(context),
                  ),
                  subtitle:
                      AppLocalizations.of(context)!.timeNotificationExplanation(
                    state.timeNotificationValue.format(context),
                  ),
                  leadingIcon: Icons.plus_one_outlined,
                ),
                _CustomListTile(
                  onTap: () async {
                    final day = await showDialog(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: CustomProperties.blurSigmaX,
                              sigmaY: CustomProperties.blurSigmaY),
                          child: DaysOfTheWeekDialog(
                              selectedDay: state.dayNotificationValue),
                        );
                      },
                    );
                    if (day != null) {
                      BlocProvider.of<NotificationBloc>(context).add(
                        DayNotificationValueEvent(day: day),
                      );
                    }
                  },
                  enabled: state.dayNotificationEnabled,
                  title: AppLocalizations.of(context)!.dayNotificationTitle(
                    state.dayNotificationValue.localizedName(context),
                  ),
                  subtitle: AppLocalizations.of(context)!
                      .dayNotificationExplanation(
                          state.dayNotificationValue.localizedName(context),
                          state.dayNotificationTimeValue.format(context)),
                  leadingIcon: Icons.calendar_month_outlined,
                  onChanged: (bool value) =>
                      BlocProvider.of<NotificationBloc>(context).add(
                    DayNotificationStateEvent(
                      enabled: value,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final bool enabled;
  final Function()? onTap;
  final Function(bool) onChanged;
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Color? iconColor;

  const _CustomListTile(
      {Key? key,
      required this.enabled,
      this.onTap,
      this.iconColor,
      required this.title,
      required this.subtitle,
      required this.leadingIcon,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      horizontalTitleGap: 0,
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
            value: enabled,
            onChanged: onChanged,
          ),
        ],
      ),
      iconColor: iconColor ?? Theme.of(context).colorScheme.primary,
      enabled: enabled,
    );
  }
}
