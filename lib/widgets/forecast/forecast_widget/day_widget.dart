part of 'forecast_widget.dart';

class _DayWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _DayWidget({required this.forecast});

  @override
  Widget build(BuildContext context) {
    final local = Localizations.localeOf(context).languageCode;

    return Text(
      forecast.circulationClosingDate.day ==
              forecast.circulationReOpeningDate.day
          ? DateFormat.MMMMEEEEd(local).format(forecast.circulationClosingDate)
          : '${DateFormat.MMMEd(local).format(forecast.circulationClosingDate)} / ${DateFormat.MMMEd(local).format(forecast.circulationReOpeningDate)}',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
