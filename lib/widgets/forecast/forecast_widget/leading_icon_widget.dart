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
    return Container(
      width: 55,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            CustomProperties.borderRadius,
          ),
          bottomLeft: Radius.circular(
            CustomProperties.borderRadius,
          ),
        ),
        color: backgroundColor,
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
