import 'package:material_ui/material_ui.dart';

class CustomProgressBarIndicator extends StatelessWidget {
  final double max;
  final double current;
  final Color color;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? textStyle;

  const CustomProgressBarIndicator({
    super.key,
    required this.max,
    required this.current,
    required this.color,
    this.height = 30,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final clampedCurrent = current.clamp(0.0, max);
    final percentage = max > 0 ? clampedCurrent / max : 0.0;

    final effectiveBackgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.inverseSurface;
    final effectiveBorderColor =
        borderColor ?? Theme.of(context).colorScheme.inverseSurface;

    return LayoutBuilder(
      builder: (_, boxConstraints) {
        final width = boxConstraints.maxWidth;
        final radius = height / 2;

        // Inset the fill so it never paints over the border stroke.
        final innerWidth = (width - borderWidth * 2).clamp(0.0, width);
        final innerHeight = (height - borderWidth * 2).clamp(0.0, height);
        final innerRadius = innerHeight / 2;
        final fillWidth = (percentage * innerWidth).clamp(0.0, innerWidth);

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Background track
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: effectiveBorderColor,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            // Progress fill, masked by the bar's FULL fixed shape so the
            // left rounded cap is always correct, even at tiny percentages.
            if (fillWidth > 0)
              Padding(
                padding: EdgeInsets.all(borderWidth),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(innerRadius),
                  child: SizedBox(
                    width: innerWidth,
                    height: innerHeight,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: fillWidth,
                        height: innerHeight,
                        child: Container(color: effectiveBackgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
