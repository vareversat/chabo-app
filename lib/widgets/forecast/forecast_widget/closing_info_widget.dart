part of 'forecast_widget.dart';

class _ClosingInfoWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final TimeFormat timeFormat;

  const _ClosingInfoWidget(
      {Key? key, required this.forecast, required this.timeFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            CustomProperties.borderRadius,
          ),
        ),
        color: Theme.of(context).colorScheme.errorContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0).copyWith(left: 12),
        child: Text(
          forecast.circulationClosingDateString(
            context,
          ),
          textAlign: TextAlign.left,
          style: textTheme.headlineSmall,
        ),
      ),
    );
  }
}
