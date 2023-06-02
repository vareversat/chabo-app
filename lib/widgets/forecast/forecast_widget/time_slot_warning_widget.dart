part of 'forecast_widget.dart';

class _TimeSlotWarningWidget extends StatelessWidget {
  const _TimeSlotWarningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: double.infinity,
      child: Icon(
        Icons.warning_rounded,
        size: 20,
        color: Theme.of(context).colorScheme.warningColor,
      ),
    );
  }
}
