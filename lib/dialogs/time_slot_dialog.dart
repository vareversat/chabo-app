import 'package:chabo/bloc/time_slot/time_slot_bloc.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeSlotDialog extends StatelessWidget {
  final int index;

  const TimeSlotDialog({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      content: BlocBuilder<TimeSlotBloc, TimeSlotState>(
        builder: (context, state) {
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 10,
            children: [
              Text(
                ' ${AppLocalizations.of(context)!.favoriteSlotsFrom} ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                onPressed: () async {
                  var time = await showTimePicker(
                    initialEntryMode: TimePickerEntryMode.dialOnly,
                    context: context,
                    initialTime: state.timeSlots[index].from,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<TimeSlotBloc>(context).add(
                      ValueTimeSlotEvent(
                          timeSlot: TimeSlot(
                              name: state.timeSlots[index].name,
                              from: time,
                              to: state.timeSlots[index].to),
                          index: index),
                    );
                  }
                },
                child: Text(
                  state.timeSlots[index].from.format(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                ' ${AppLocalizations.of(context)!.favoriteSlotsTo} ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                onPressed: () async {
                  var time = await showTimePicker(
                    initialEntryMode: TimePickerEntryMode.dialOnly,
                    context: context,
                    initialTime: state.timeSlots[index].to,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<TimeSlotBloc>(context).add(
                      ValueTimeSlotEvent(
                          timeSlot: TimeSlot(
                              name: state.timeSlots[index].name,
                              from: state.timeSlots[index].from,
                              to: time),
                          index: index),
                    );
                  }
                },
                child: Text(
                  state.timeSlots[index].to.format(context),
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
