import 'dart:ui';

import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/dialogs/time_slot_dialog.dart';
import 'package:chabo_app/extensions/time_of_day_extension.dart';
import 'package:chabo_app/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeSlotWidget extends StatelessWidget {
  final TimeSlot timeSlot;
  final int index;

  const TimeSlotWidget({Key? key, required this.timeSlot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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
              child: TimeSlotDialog(
                index: index,
              ),
            );
          },
        ).then(
          (value) => {
            if (value != null)
              {
                BlocProvider.of<NotificationBloc>(context).add(
                  DayNotificationValueEvent(day: value),
                ),
              },
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TimeFormatCubit, TimeFormatState>(
          builder: (context, timeFormatState) {
            return Column(
              children: [
                Text(
                  timeSlot.name != ''
                      ? timeSlot.name
                      : AppLocalizations.of(context)!
                          .favoriteTimeSlotDefaultName(index + 1),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${timeSlot.from.toFormattedString(timeFormatState.timeFormat)} - ${timeSlot.to.toFormattedString(timeFormatState.timeFormat)}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
