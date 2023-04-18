import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysOfTheWeekDialog extends StatelessWidget {
  final Day selectedDay;

  const DaysOfTheWeekDialog({Key? key, required this.selectedDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      content: BlocBuilder<NotificationBloc, NotificationSate>(
        builder: (context, state) {
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 10,
            children: [
              Text('Le '),
              DropdownButton(
                borderRadius:  BorderRadius.circular(12.0),
                onChanged: (Day? value) {
                  Navigator.pop(context, value);
                },
                value: Day.friday,
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
              Text(' à '),
              Text(
                state.dayNotificationTimeValue.format(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          );
        },
      ),
    );
  }
}
