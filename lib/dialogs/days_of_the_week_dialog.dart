import 'package:chabo_app/bloc/notification/notification_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/extensions/time_of_day_extension.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/enums/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysOfTheWeekDialog extends StatelessWidget {
  const DaysOfTheWeekDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CustomProperties.borderRadius),
      ),
      content: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return BlocBuilder<TimeFormatCubit, TimeFormatState>(
            builder: (context, timeFormatState) {
              return Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                runSpacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {}, // ignore: no-empty-block
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(12.0),
                        onChanged: (Day? value) {
                          if (value != null) {
                            BlocProvider.of<NotificationBloc>(
                              context,
                            ).add(DayNotificationValueEvent(day: value));
                          }
                        },
                        value: state.dayNotificationValue,
                        items: Day.values
                            .map(
                              (day) => DropdownMenuItem<Day>(
                                value: day,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    day.localizedName(context),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Text(
                    ' ${AppLocalizations.of(context)!.dayNotificationAt} ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showTimePicker(
                        initialEntryMode: TimePickerEntryMode.dial,
                        context: context,
                        initialTime: state.dayNotificationTimeValue,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context),
                            child: child!,
                          );
                        },
                      ).then(
                        (value) => {
                          if (value != null)
                            {
                              if (context.mounted)
                                BlocProvider.of<NotificationBloc>(context).add(
                                  DayNotificationTimeValueEvent(time: value),
                                ),
                            },
                        },
                      );
                    },
                    child: Text(
                      state.dayNotificationTimeValue.toFormattedString(
                        timeFormatState.timeFormat,
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    CustomProperties.borderRadius,
                  ),
                ),
              ),
            ),
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.check_circle),
            label: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ),
      ],
    );
  }
}
