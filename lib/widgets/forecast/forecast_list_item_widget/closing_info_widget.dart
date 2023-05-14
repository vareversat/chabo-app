part of 'forecast_list_item_widget.dart';

class _ClosingInfoWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _ClosingInfoWidget({Key? key, required this.forecast})
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
              Icons.block_rounded,
              size: 18,
              color: Colors.red,
            ),
            Text(
              MaterialLocalizations.of(context).formatMediumDate(
                forecast.circulationClosingDate,
              ),
              style: textTheme.bodySmall,
            ),
          ],
        ),
        Text(
          forecast.circulationClosingDateString(
            context,
          ),
          style: textTheme.headlineSmall,
        ),
      ],
    );
  }
}
