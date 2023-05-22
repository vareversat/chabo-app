import 'package:chabo/bloc/status/status_bloc.dart';
import 'package:chabo/extensions/boats_extension.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/models/boat_forecast.dart';
import 'package:flutter/material.dart';

class CurrentDockedBoatBottomSheet extends StatefulWidget {
  final StatusState statusState;

  const CurrentDockedBoatBottomSheet({
    super.key,
    required this.statusState,
  });

  @override
  State<StatefulWidget> createState() {
    return _CurrentDockedBoatBottomSheetState();
  }
}

class _CurrentDockedBoatBottomSheetState
    extends State<CurrentDockedBoatBottomSheet> with TickerProviderStateMixin {
  late AnimationController _mainIconController;
  final Tween<double> _tween = Tween(begin: 0, end: 1);
  final _duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();

    _mainIconController = AnimationController(
      duration: _duration,
      vsync: this,
    );

    _mainIconController.forward();
  }

  @override
  void dispose() {
    _mainIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boatForecast = (widget.statusState.previousForecast as BoatForecast);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _tween.animate(
                    CurvedAnimation(
                      parent: _mainIconController,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Theme.of(context).colorScheme.boatColor,
                    child: Icon(
                      Icons.info_rounded,
                      color: Theme.of(context).cardColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 5,
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: boatForecast.boats.toLocalizedMoonHarborStatus(
                  context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
