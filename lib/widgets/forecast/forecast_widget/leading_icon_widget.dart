part of 'forecast_widget.dart';

class _LeadingIconWidget extends StatelessWidget {
  final AbstractForecast forecast;
  final Color? backgroundColor;

  const _LeadingIconWidget({
    Key? key,
    required this.forecast,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: forecast.getIconWidget(context, false, 30, false),
            ),
          ),
          Center(
            child: Text(
              forecast.getClosingReason(context),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
