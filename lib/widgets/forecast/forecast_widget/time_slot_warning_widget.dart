part of 'forecast_widget.dart';

class _TimeSlotWarningWidget extends StatelessWidget {
  const _TimeSlotWarningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(
            CustomProperties.borderRadius,
          ),
          bottomLeft: Radius.circular(
            CustomProperties.borderRadius,
          ),
        ),
        color: Theme.of(context).colorScheme.warningColor,
      ),
      height: double.infinity,
      child: Icon(
        Icons.warning_rounded,
        size: 20,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
