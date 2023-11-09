part of 'status_widget.dart';

class _LayoutWidget extends StatelessWidget {
  final StatusState statusState;

  const _LayoutWidget({
    required this.statusState,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _TextWidget(
                  statusState: statusState,
                ),
              ),
              if (statusState.currentForecast != null)
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
          ),
        ),
      ),
    );
  }
}
