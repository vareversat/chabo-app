import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DaysOfTheWeekDialog extends StatelessWidget {
  final Day selectedDay;

  const DaysOfTheWeekDialog({Key? key, required this.selectedDay})
      : super(key: key);

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      content: Column(
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
                groupValue: selectedDay,
                onChanged: (Day? value) {
                  Navigator.pop(context, value);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
