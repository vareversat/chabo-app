part of 'forecast_widget.dart';

class _OpeningInfoWidget extends StatelessWidget {
  final AbstractForecast forecast;

  const _OpeningInfoWidget({Key? key, required this.forecast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
        child: Text(
          forecast.circulationReOpeningDateString(
            context,
          ),
          textAlign: TextAlign.right,
          style: textTheme.headlineSmall,
        ),
      ),
    );
  }
}
