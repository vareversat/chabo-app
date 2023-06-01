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
          DateFormat.MMMEd().format(
            forecast.circulationClosingDate,
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Icon(
          FontAwesomeIcons.arrowRightLong,
          size: 20,
        ),
      ],
    );
  }
}
