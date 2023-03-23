import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DaysOfTheWeekDialog extends StatelessWidget {
  const DaysOfTheWeekDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(20),
      actionsPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        20,
        10,
      ),
      title: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              15.0,
            ),
            topRight: Radius.circular(
              15.0,
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          0,
          15,
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_month_outlined,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            const SizedBox(width: 20),
            Text(
              AppLocalizations.of(context)!.day,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      content: BlocBuilder<NotificationBloc, NotificationSate>(
          builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: Day.values
              .map(
                (day) => RadioListTile<Day>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      CustomProperties.borderRadius,
                    ),
                  ),
                  title: Text(
                    day.localizedName(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: day,
                  groupValue: state.dayNotificationValue,
                  onChanged: (Day? value) {
                    Navigator.pop(context, value);
                  },
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
