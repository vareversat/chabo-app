part of 'forecast_widget.dart';

class _OpeningInfoWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _OpeningInfoWidget({Key? key, required this.forecast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.check_circle,
              size: 18,
              color: Colors.green,
            ),
            Text(
              MaterialLocalizations.of(context).formatMediumDate(
                forecast.circulationReOpeningDate,
              ),
              style: textTheme.bodySmall,
            ),
          ],
        ),
        Text(
          forecast.circulationReOpeningDateString(
            context,
          ),
          style: textTheme.headlineSmall,
        ),
      ],
    );
  }
}
