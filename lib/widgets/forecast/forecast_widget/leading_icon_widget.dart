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
      height: 60,
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
      child: Center(
        child: forecast.getIconWidget(
          context,
          true,
        ),
      ),
    );
  }
}
