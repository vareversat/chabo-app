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
        color: Theme.of(context).buttonTheme.colorScheme?.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          forecast.closedDuration.durationToString(context),
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
