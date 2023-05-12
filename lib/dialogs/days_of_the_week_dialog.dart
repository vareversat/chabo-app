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
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          CustomProperties.borderRadius,
        ),
      ),
      content: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
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
                        BlocProvider.of<NotificationBloc>(context).add(
                          DayNotificationValueEvent(
                            day: value,
                          ),
                        );
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
                    initialEntryMode: TimePickerEntryMode.dialOnly,
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
                          BlocProvider.of<NotificationBloc>(context).add(
                            DayNotificationTimeValueEvent(
                              time: value,
                            ),
                          ),
                        },
                    },
                  );
                },
                child: Text(
                  state.dayNotificationTimeValue.format(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
