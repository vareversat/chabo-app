import 'dart:ui';

import 'package:flutter/scheduler.dart';

import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/bloc/time_slots/time_slots_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/dialogs/days_of_the_week_dialog.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/extensions/duration_extension.dart';
import 'package:chabo_app/extensions/time_of_day_extension.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/enums/day.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/widgets/chabo_app_bar/chabo_app_bar.dart';
import 'package:chabo_app/widgets/simple_container.dart';
import 'package:chabo_app/widgets/time_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'custom_list_tile_widget.dart';
part 'favorite_slots_day_picker_dialog.dart';
part 'favorite_slots_widget.dart';

class NotificationScreen extends StatefulWidget {
  final bool? highlightTimeSlots;
  static const routeName = '/notification-screen';

  const NotificationScreen({super.key, this.highlightTimeSlots});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends CustomWidgetState<NotificationScreen> {
  _NotificationScreenState() : super(screenName: 'notification-screen');

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkNotificationsEnabled();
    });
  }

  Future<void> _checkNotificationsEnabled() async {
    if (!mounted) return;
    final storageService = BlocProvider.of<NotificationBloc>(context).storageService;
    final hasShown = storageService.sharedPreferences.getBool(Const.notificationPermissionShownKey) ?? false;
    if (hasShown) return;
    
    final notificationService = BlocProvider.of<NotificationBloc>(context)
        .notificationService;
    final areEnabled = await notificationService.areNotificationsEnabled();
    if (!areEnabled && mounted) {
      await storageService.saveBool(Const.notificationPermissionShownKey, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
          backgroundColor: Theme.of(context).colorScheme.errorColor,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.notificationsDisabledMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.enableNotificationsButton,
            textColor: Colors.white,
            onPressed: (() async {
              await notificationService.requestPermissions();
            }),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChaboAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, notificationState) {
            return BlocBuilder<TimeFormatCubit, TimeFormatState>(
              builder: (context, timeFormatState) {
                return Column(
                  spacing: 10,
                  children: [
                    _FavoriteSlotsWidget(
                      highlightTimeSlots: widget.highlightTimeSlots ?? false,
                      timeSlotsEnabledForNotifications:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                    const Divider(
                      height: 10,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    _CustomListTileWidget(
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(
                            context,
                          ).add(OpeningNotificationStateEvent(enabled: value)),
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
                    _CustomListTileWidget(
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(
                            context,
                          ).add(ClosingNotificationStateEvent(enabled: value)),
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
                    _CustomListTileWidget(
                      onTap: () {
                        showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                          initialTime: notificationState
                              .durationNotificationValue
                              .durationToTimeOfDay(),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) => {
                            if (value != null)
                              {
                                if (context.mounted)
                                  BlocProvider.of<NotificationBloc>(context)
                                      .add(
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
                          BlocProvider.of<NotificationBloc>(
                            context,
                          ).add(DurationNotificationStateEvent(enabled: value)),
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
                    _CustomListTileWidget(
                      onTap: () {
                        showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                          initialTime: notificationState.timeNotificationValue,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat:
                                    timeFormatState.timeFormat ==
                                    TimeFormat.twentyFourHours,
                              ),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) => {
                            if (value != null)
                              {
                                if (context.mounted)
                                  BlocProvider.of<NotificationBloc>(context)
                                      .add(
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
                          BlocProvider.of<NotificationBloc>(context)
                              .add(TimeNotificationStateEvent(enabled: value)),
                      enabled: notificationState.timeNotificationEnabled,
                      title: AppLocalizations.of(context)!
                          .timeNotificationTitle(
                            notificationState.timeNotificationValue
                                .toFormattedString(timeFormatState.timeFormat),
                          ),
                      subtitle: AppLocalizations.of(context)!
                          .timeNotificationExplanation(
                            notificationState.timeNotificationValue
                                .toFormattedString(timeFormatState.timeFormat),
                          ),
                      leadingIcon: Icons.plus_one_outlined,
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                    _CustomListTileWidget(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
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
                                if (context.mounted)
                                  BlocProvider.of<NotificationBloc>(
                                    context,
                                  ).add(DayNotificationValueEvent(day: value)),
                              },
                          },
                        );
                      },
                      enabled: notificationState.dayNotificationEnabled,
                      title: AppLocalizations.of(context)!.dayNotificationTitle(
                        notificationState.dayNotificationValue.localizedName(
                          context,
                        ),
                      ),
                      subtitle: AppLocalizations.of(context)!
                          .dayNotificationExplanation(
                            notificationState.dayNotificationValue
                                .localizedName(context),
                            notificationState.dayNotificationTimeValue
                                .toFormattedString(timeFormatState.timeFormat),
                          ),
                      leadingIcon: Icons.calendar_month_outlined,
                      onChanged: (bool value) =>
                          BlocProvider.of<NotificationBloc>(context)
                              .add(DayNotificationStateEvent(enabled: value)),
                      constrainedBySlots:
                          notificationState.timeSlotsEnabledForNotifications,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
