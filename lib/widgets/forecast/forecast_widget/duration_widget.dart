part of 'forecast_widget.dart';

class _DurationWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _DurationWidget({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          forecast.closedDuration.durationToString(context),
          style: TextStyle(
            color: Theme.of(context).colorScheme.timeColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const Icon(
          FontAwesomeIcons.arrowRightLong,
          size: 20,
        ),
      ],
    );
  }
}
