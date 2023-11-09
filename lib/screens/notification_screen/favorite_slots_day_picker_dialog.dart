part of 'notification_screen.dart';

class FavoriteSlotsDayPickerDialog extends StatelessWidget {
  const FavoriteSlotsDayPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          CustomProperties.borderRadius,
        ),
      ),
      content: BlocBuilder<TimeSlotsBloc, TimeSlotsState>(
        builder: (context, state) {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: Day.values.map((Day day) {
              return FilterChip(
                avatar: state.days.contains(day)
                    ? null
                    : Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                label: Text(
                  day.localizedName(context),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                selected: state.days.contains(day),
                shape: const StadiumBorder(side: BorderSide()),
                onSelected: (bool selected) =>
                    BlocProvider.of<TimeSlotsBloc>(context).add(
                  DaysChanged(
                    day: day,
                    isSelected: selected,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    CustomProperties.borderRadius,
                  ),
                ),
              ),
            ),
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.check_circle),
            label: Text(
              MaterialLocalizations.of(context).okButtonLabel,
            ),
          ),
        ),
      ],
    );
  }
}
