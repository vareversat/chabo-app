part of 'forecast_widget.dart';

class _OpeningInfoWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final TimeFormat timeFormat;

  const _OpeningInfoWidget(
      {Key? key, required this.forecast, required this.timeFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(
            CustomProperties.borderRadius,
          ),
        ),
        color: Theme.of(context).colorScheme.okColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0).copyWith(right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: forecast.circulationReOpeningDate.toLocalizedTextSpan(
                context,
                Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
