part of 'status_screen.dart';

class DurationWidget extends StatelessWidget {
  final StatusState statusState;

  const DurationWidget({super.key, required this.statusState});

  @override
  Widget build(BuildContext context) {
    final days = statusState.durationUntilNextEvent.inDays;
    final hours = statusState.durationUntilNextEvent.inHours.remainder(24);
    final minutes = statusState.durationUntilNextEvent.inMinutes.remainder(60);
    final seconds = statusState.durationUntilNextEvent.inSeconds.remainder(60);

    final textTheme = Theme.of(context).textTheme;
    final unitTheme = textTheme.titleSmall;
    return Column(
      spacing: 8,
      children: [
        Text(statusState.timeMessagePrefix),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Days (3 digits)
            if (days != 0 || (hours == 0 && minutes == 0 && seconds == 0))
              ..._buildDigitBoxes(days.toString().padLeft(3, '0'), context),
            if (days != 0 || (hours == 0 && minutes == 0 && seconds == 0))
              Text(AppLocalizations.of(context)!.daySmall, style: unitTheme),
            const SizedBox(width: 8),

            // Hours (2 digits)
            if (hours != 0 || (minutes == 0 && seconds == 0))
              ..._buildDigitBoxes(hours.toString().padLeft(2, '0'), context),
            if (hours != 0 || (minutes == 0 && seconds == 0))
              Text('h', style: unitTheme),
            const SizedBox(width: 8),

            // Minutes (2 digits)
            if (minutes != 0 || seconds == 0)
              ..._buildDigitBoxes(minutes.toString().padLeft(2, '0'), context),
            if (minutes != 0 || seconds == 0) Text('m', style: unitTheme),
            const SizedBox(width: 8),

            // Seconds (2 digits)
            ..._buildDigitBoxes(seconds.toString().padLeft(2, '0'), context),
            Text('s', style: unitTheme),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildDigitBoxes(String digits, BuildContext context) {
    return digits.split('').map((digit) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 10),
        child: Container(
          key: ValueKey<String>('$digits$digit'),
          width: 25,
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(digit, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
      );
    }).toList();
  }
}
