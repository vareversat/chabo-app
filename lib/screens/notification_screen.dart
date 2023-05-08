import 'dart:ui';

import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/cubits/floating_actions_cubit.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widget_state.dart';
import 'package:chabo/dialogs/days_of_the_week_dialog.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/misc/no_scaling_animation.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:chabo/widgets/time_slot_widget.dart';
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
    return BlocBuilder<FloatingActionsCubit, FloatingActionsState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: Wrap(
              spacing: 10,
              children: [
                Text(
                  MaterialLocalizations.of(context).closeButtonLabel,
                ),
                const Icon(Icons.close),
              ],
            ),
          ),
          floatingActionButtonLocation: state.isRightHanded
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.startFloat,
          floatingActionButtonAnimator: NoScalingAnimation(),
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
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, notificationState) {
                return Column(
                  children: [
                    Column(
                      children: [
                        _CustomListTile(
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
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .warningColor,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(
                                  reason: SnackBarClosedReason.action,
                                ),
                              },
                          },
                          enabled: notificationState
                              .timeSlotsEnabledForNotifications,
                          title: AppLocalizations.of(context)!.favoriteSlots,
                          subtitle: AppLocalizations.of(context)!
                              .favoriteSlotsDescription,
                          leadingIcon: Icons.warning_rounded,
                          iconColor: Theme.of(context).colorScheme.warningColor,
                          constrainedBySlots: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (var i = 0;
                                  i < notificationState.timeSlotsValue.length;
                                  i++) ...[
                                TimeSlotWidget(
                                  timeSlot: notificationState.timeSlotsValue[i],
                                  index: i,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _CustomListTile(
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(context).add(
                        OpeningNotificationStateEvent(
                          enabled: value,
                        ),
                      ),
                      enabled: notificationState.openingNotificationEnabled,
                      title: AppLocalizations.of(context)!
                          .openingNotificationTitle,
                      subtitle: AppLocalizations.of(context)!
                          .openingNotificationExplanation,
                      leadingIcon: Icons.check_circle,
                      iconColor: Colors.green,
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                    _CustomListTile(
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(context).add(
                        ClosingNotificationStateEvent(
                          enabled: value,
                        ),
                      ),
                      enabled: notificationState.closingNotificationEnabled,
                      title: AppLocalizations.of(context)!
                          .closingNotificationTitle,
                      subtitle: AppLocalizations.of(context)!
                          .closingNotificationExplanation,
                      leadingIcon: Icons.block_rounded,
                      iconColor: Colors.red,
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _CustomListTile(
                      onTap: () {
                        showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dialOnly,
                          context: context,
                          initialTime: notificationState
                              .durationNotificationValue
                              .durationToTimeOfDay(),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: true,
                              ),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) => {
                            if (value != null)
                              {
                                BlocProvider.of<NotificationBloc>(context).add(
                                  DurationNotificationValueEvent(
                                    duration: Duration(
                                      hours: value.hour,
                                      minutes: value.minute,
                                    ),
                                  ),
                                ),
                              },
                          },
                        );
                      },
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(context).add(
                        DurationNotificationStateEvent(
                          enabled: value,
                        ),
                      ),
                      enabled: notificationState.durationNotificationEnabled,
                      title: AppLocalizations.of(context)!
                          .durationNotificationTitle(
                        notificationState.durationNotificationValue
                            .durationToString(context),
                      ),
                      subtitle: AppLocalizations.of(context)!
                          .durationNotificationExplanation(
                        notificationState.durationNotificationValue
                            .durationToString(context),
                      ),
                      leadingIcon: Icons.timer_outlined,
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                    _CustomListTile(
                      onTap: () {
                        showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dialOnly,
                          context: context,
                          initialTime: notificationState.timeNotificationValue,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: false,
                              ),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) => {
                            if (value != null)
                              {
                                BlocProvider.of<NotificationBloc>(context).add(
                                  TimeNotificationValueEvent(
                                    time: TimeOfDay(
                                      hour: value.hour,
                                      minute: value.minute,
                                    ),
                                  ),
                                ),
                              },
                          },
                        );
                      },
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(context).add(
                        TimeNotificationStateEvent(
                          enabled: value,
                        ),
                      ),
                      enabled: notificationState.timeNotificationEnabled,
                      title:
                          AppLocalizations.of(context)!.timeNotificationTitle(
                        notificationState.timeNotificationValue.format(context),
                      ),
                      subtitle: AppLocalizations.of(context)!
                          .timeNotificationExplanation(
                        notificationState.timeNotificationValue.format(context),
                      ),
                      leadingIcon: Icons.plus_one_outlined,
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                    _CustomListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (
                            BuildContext context,
                          ) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: CustomProperties.blurSigmaX,
                                sigmaY: CustomProperties.blurSigmaY,
                              ),
                              child: const DaysOfTheWeekDialog(),
                            );
                          },
                        ).then(
                          (value) => {
                            if (value != null)
                              {
                                BlocProvider.of<NotificationBloc>(context).add(
                                  DayNotificationValueEvent(
                                    day: value,
                                  ),
                                ),
                              },
                          },
                        );
                      },
                      enabled: notificationState.dayNotificationEnabled,
                      title: AppLocalizations.of(context)!.dayNotificationTitle(
                        notificationState.dayNotificationValue
                            .localizedName(context),
                      ),
                      subtitle: AppLocalizations.of(context)!
                          .dayNotificationExplanation(
                        notificationState.dayNotificationValue
                            .localizedName(context),
                        notificationState.dayNotificationTimeValue.format(
                          context,
                        ),
                      ),
                      leadingIcon: Icons.calendar_month_outlined,
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(context).add(
                        DayNotificationStateEvent(
                          enabled: value,
                        ),
                      ),
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final bool enabled;
  final bool constrainedBySlots;
  final Function()? onTap;
  final Function(bool) onChanged;
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Color? iconColor;

  const _CustomListTile({
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
              duration: const Duration(milliseconds: 200),
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
