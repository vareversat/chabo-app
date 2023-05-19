part of 'status_widget.dart';

class _LayoutWidget extends StatelessWidget {
  final StatusState statusState;

  const _LayoutWidget({
    Key? key,
    required this.statusState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TextWidget(
          statusState: statusState,
        ),
        _ProgressIndicatorWidget(
          statusState: statusState,
        ),
        const SizedBox(
          height: 10,
        ),
        _CurrentStatusWidget(
          statusState: statusState,
        ),
      ],
    );
  }
}
