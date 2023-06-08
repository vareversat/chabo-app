import 'package:chabo/custom_properties.dart';
import 'package:flutter/material.dart';

class CustomProgressBarIndicator extends StatelessWidget {
  final double max;
  final double current;
  final Color color;

  const CustomProgressBarIndicator({
    Key? key,
    required this.max,
    required this.current,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: CustomProperties.animationDurationMs,
              ),
              width: x,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: CustomProperties.animationDurationMs,
              ),
              width: percent,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
