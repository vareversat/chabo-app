part of 'chabo_about_screen.dart';

class _StoreRateWidget extends StatefulWidget {
  const _StoreRateWidget();

  @override
  State<_StoreRateWidget> createState() => _StoreRateWidgetState();
}

class _StoreRateWidgetState extends State<_StoreRateWidget>
    with SingleTickerProviderStateMixin {
  final InAppReview inAppReview = InAppReview.instance;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openRating() async {
    return await inAppReview.isAvailable()
        ? inAppReview.requestReview()
        : inAppReview.openStoreListing();
  }

  List<Widget> _computeIconWidgets() {
    final icons = <Widget>[];
    const iconCount = 5;
    for (var index = 0; index < iconCount; index++) {
      icons.add(
        FadeTransition(
          opacity: _animation.drive(
            CurveTween(
              curve: Interval(
                0,
                1 / (iconCount - index),
                curve: Curves.easeInCubic,
              ),
            ),
          ),
          child: const Icon(
            Icons.star,
          ),
        ),
      );
    }

    return icons;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          colorScheme.warningColor,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).cardColor,
        ),
      ),
      onPressed: () => _openRating(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.ideographic,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
            ),
            child: Text(
              '${AppLocalizations.of(context)!.rate} ${Const.appName} ❤️',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: _computeIconWidgets(),
          ),
        ],
      ),
    );
  }
}
