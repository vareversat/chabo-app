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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: forecast.getIconWidget(
              context,
              false,
              25,
            ),
          ),
          Center(
            child: Text(
              forecast.getClosingReason(context),
              style: Theme.of(context).textTheme.labelSmall,
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
