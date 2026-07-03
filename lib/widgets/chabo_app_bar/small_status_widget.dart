part of 'chabo_app_bar.dart';

class SmallStatusWidget extends StatelessWidget {
  const SmallStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusState>(
      builder: (context, statusState) {
        if (statusState.statusLifecycle == StatusLifecycle.populated) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                child: CustomProgressBarIndicator(
                  max: 1,
                  current: statusState.completionPercentage,
                  color: statusState.backgroundColor,
                ),
              ),
              Text(
                statusState.smallMessageStatus,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: statusState.foregroundColor,
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
