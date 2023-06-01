part of 'forecast_widget.dart';

class _OpeningInfoWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final TimeFormat timeFormat;

  const _OpeningInfoWidget(
      {Key? key, required this.forecast, required this.timeFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Center(
            child: Text(
              forecast.circulationReOpeningDateString(
                context,
              ),
              style: textTheme.headlineMedium,
            ),
          ),
        ),
        Container(
          height: 32,
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                CustomProperties.borderRadius / 2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            child: Text(
              'Ouverture',
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
