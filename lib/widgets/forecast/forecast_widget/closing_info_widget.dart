part of 'forecast_widget.dart';

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
        Expanded(
          child: Center(
            child: Text(
              forecast.circulationClosingDateString(
                context,
              ),
              style: textTheme.headlineMedium,
            ),
          ),
        ),
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                CustomProperties.borderRadius / 2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
            child: Text(
              'Fermeture',
              style: textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
