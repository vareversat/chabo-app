part of 'forecast_widget.dart';

class _TimeSlotWarningWidget extends StatelessWidget {
  const _TimeSlotWarningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(
            CustomProperties.borderRadius,
          ),
          bottomRight: Radius.circular(
            CustomProperties.borderRadius,
          ),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Icon(
        Icons.warning_rounded,
        size: 20,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
