import 'package:chabo/bloc/notification/notification_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeSlotDialog extends StatelessWidget {
  final int index;

  const TimeSlotDialog({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              Text(
                ' ${AppLocalizations.of(context)!.favoriteSlotsFrom} ',
                style: textTheme.titleMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  showTimePicker(
                    initialEntryMode: TimePickerEntryMode.dialOnly,
                    context: context,
                    initialTime: state.timeSlotsValue[index].from,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context),
                        child: child!,
                      );
                    },
                  ).then((value) => {
                        if (value != null)
                          {
                            BlocProvider.of<NotificationBloc>(context).add(
                              ValueTimeSlotEvent(
                                timeSlot: TimeSlot(
                                  name: state.timeSlotsValue[index].name,
                                  from: value,
                                  to: state.timeSlotsValue[index].to,
                                ),
                                index: index,
                              ),
                            ),
                          },
                      });
                },
                child: Text(
                  state.timeSlotsValue[index].from.format(context),
                  style: textTheme.titleMedium,
                ),
              ),
              Text(
                ' ${AppLocalizations.of(context)!.favoriteSlotsTo} ',
                style: textTheme.titleMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  showTimePicker(
                    initialEntryMode: TimePickerEntryMode.dialOnly,
                    context: context,
                    initialTime: state.timeSlotsValue[index].to,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context),
                        child: child!,
                      );
                    },
                  ).then((value) => {
                        if (value != null)
                          {
                            BlocProvider.of<NotificationBloc>(context).add(
                              ValueTimeSlotEvent(
                                timeSlot: TimeSlot(
                                  name: state.timeSlotsValue[index].name,
                                  from: state.timeSlotsValue[index].from,
                                  to: value,
                                ),
                                index: index,
                              ),
                            ),
                          },
                      });
                },
                child: Text(
                  state.timeSlotsValue[index].to.format(context),
                  style: textTheme.titleMedium,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
