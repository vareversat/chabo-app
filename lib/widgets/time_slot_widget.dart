import 'dart:ui';

import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/time_slot_dialog.dart';
import 'package:chabo/models/time_slot.dart';
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
      onPressed: () async {
        final day = await showDialog(
          context: context,
          builder: (
            BuildContext context,
          ) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: CustomProperties.blurSigmaX,
                  sigmaY: CustomProperties.blurSigmaY),
              child: TimeSlotDialog(
                index: index,
              ),
            );
          },
        );
        if (day != null) {
          BlocProvider.of<NotificationBloc>(context).add(
            DayNotificationValueEvent(day: day),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              timeSlot.name != ''
                  ? timeSlot.name
                  : AppLocalizations.of(context)!
                      .favoriteTimeSlotDefaultName(index + 1),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${timeSlot.from.format(context)} - ${timeSlot.to.format(context)}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
