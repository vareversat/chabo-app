import 'package:chabo_app/custom_properties.dart';
import 'package:flutter/material.dart';

/// A loading bar widget that displays a green rectangle clipped with a custom
/// curved path to create an animated loading effect.
class CurvedLoadingBar extends StatefulWidget {
  /// The color of the loading bar. Defaults to green.
  final Color color;

  /// The width of the loading bar.
  final double width;

  /// The height of the loading bar.
  final double height;

  /// The duration of one complete loading animation cycle.
  final Duration animationDuration;

  /// The curve used for the animation.
  final Curve animationCurve;

  /// Whether the animation should repeat indefinitely.
  final bool isLoading;

  /// The progress value (0.0 to 1.0) when not in loading mode.
  final double progress;

  const CurvedLoadingBar({
    super.key,
    this.color = Colors.green,
    this.width = double.infinity,
    this.height = 20,
    this.animationDuration = const Duration(
      milliseconds: CustomProperties.animationDurationMs,
    ),
    this.animationCurve = Curves.easeInOut,
    this.isLoading = true,
    this.progress = 0.0,
  }) : assert(progress >= 0.0 && progress <= 1.0, 'Progress must be between 0.0 and 1.0');

  @override
  State<CurvedLoadingBar> createState() => _CurvedLoadingBarState();
}

class _CurvedLoadingBarState extends State<CurvedLoadingBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );

    if (widget.isLoading) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = widget.progress;
    }
  }

  @override
  void didUpdateWidget(CurvedLoadingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = widget.progress;
      }
    }
    if (widget.progress != oldWidget.progress && !widget.isLoading) {
      _controller.value = widget.progress;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipPath(
        clipper: _CurvedLoadingClipper(_animation, widget.isLoading),
        child: Container(
          width: widget.width,
          height: widget.height,
          color: widget.color,
        ),
      ),
    );
  }
}

/// Custom clipper that creates a curved path for the loading animation.
/// The path creates a wave-like effect that moves across the rectangle.
class _CurvedLoadingClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final bool isLoading;

  const _CurvedLoadingClipper(this.animation, this.isLoading);

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    // Calculate the position of the curve based on animation value
    final progress = isLoading ? animation.value : 1.0;
    final curvePosition = width * progress * 2;

    // Start from the left
    path.moveTo(0, 0);

    // Create a wave-like curve that moves from left to right
    // The curve consists of multiple sine-wave segments
    final segments = 3;
    final segmentWidth = width / segments;

    for (var i = 0; i <= segments; i++) {
      final x = i * segmentWidth - curvePosition;
      // Calculate the y position using a sine wave
      final y = height * 0.5 * (1 + sin((x / width) * 2 * pi * segments + animation.value * 2 * pi));
      
      if (i == 0) {
        path.lineTo(x, y);
      } else {
        // Create smooth curves between points
        final prevX = (i - 1) * segmentWidth - curvePosition;
        final prevY = height * 0.5 * (1 + sin(((prevX) / width) * 2 * pi * segments + animation.value * 2 * pi));
        
        final controlX1 = prevX + (x - prevX) / 3;
        final controlY1 = prevY;
        final controlX2 = x - (x - prevX) / 3;
        final controlY2 = y;
        
        path.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
      }
    }

    // Close the path by going to bottom right and back to start
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

/// A simpler version with a single curved wave
class CurvedLoadingBarSimple extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final Duration animationDuration;
  final bool isLoading;
  final double progress;

  const CurvedLoadingBarSimple({
    super.key,
    this.color = Colors.green,
    this.width = double.infinity,
    this.height = 20,
    this.animationDuration = const Duration(
      milliseconds: CustomProperties.animationDurationMs,
    ),
    this.isLoading = true,
    this.progress = 0.0,
  }) : assert(progress >= 0.0 && progress <= 1.0, 'Progress must be between 0.0 and 1.0');

  @override
  State<CurvedLoadingBarSimple> createState() => _CurvedLoadingBarSimpleState();
}

class _CurvedLoadingBarSimpleState extends State<CurvedLoadingBarSimple> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.value = widget.progress;
    }
  }

  @override
  void didUpdateWidget(CurvedLoadingBarSimple oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.value = widget.progress;
      }
    }
    if (widget.progress != oldWidget.progress && !widget.isLoading) {
      _controller.value = widget.progress;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: ClipPath(
            clipper: _SimpleCurveClipper(_animation.value, widget.progress, widget.isLoading),
            child: Container(
              width: widget.width,
              height: widget.height,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

/// Simple curve clipper that creates a single moving curve
class _SimpleCurveClipper extends CustomClipper<Path> {
  final double animationValue;
  final double progress;
  final bool isLoading;

  const _SimpleCurveClipper(this.animationValue, this.progress, this.isLoading);

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    final effectiveProgress = isLoading ? animationValue : progress;
    final curveWidth = width * 0.4;
    final curvePosition = (width + curveWidth) * effectiveProgress - curveWidth;

    // Start from left
    path.moveTo(0, 0);
    
    // Line to start of curve
    path.lineTo(curvePosition, 0);
    
    // Create a cubic bezier curve (like a hill)
    final curveHeight = height * 0.8;
    path.cubicTo(
      curvePosition + curveWidth * 0.25,
      0,
      curvePosition + curveWidth * 0.5,
      curveHeight,
      curvePosition + curveWidth * 0.75,
      0,
    );
    
    // Line to end
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
