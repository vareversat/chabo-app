import 'package:material_ui/material_ui.dart';

class WaveDivider extends StatefulWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final bool animate;

  const WaveDivider({
    super.key,
    this.height = 30,
    this.thickness = 3,
    this.indent = 0,
    this.endIndent = 0,
    this.animate = false,
  });

  @override
  State<WaveDivider> createState() => _WaveDividerState();
}

class _WaveDividerState extends State<WaveDivider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(WaveDivider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size(double.infinity, widget.height),
            painter: _WavePainter(
              color: Theme.of(context).dividerColor,
              thickness: widget.thickness,
              indent: widget.indent,
              endIndent: widget.endIndent,
              phase: widget.animate ? _controller.value : 0.0,
            ),
          );
        },
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  final double phase;

  _WavePainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
    required this.phase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final path = Path();
    final double midY = size.height / 2;
    final double waveHeight = size.height / 2;
    final double endX = size.width - endIndent;

    // Number of full wave cycles to fit in the drawable width.
    final double drawWidth = endX - indent;
    final double waveLength = drawWidth / 4;

    // Phase offset in pixels for animation (one full cycle = waveLength px).
    final double phaseOffset = phase * waveLength;

    // Start at indent, shifted back by one cycle so the phase feels
    // like it propagates from the left edge.
    double x = indent - waveLength + phaseOffset;

    // Clip drawing to [indent … endX] so phase-shifted waves don't bleed.
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(indent, 0, drawWidth, size.height));

    path.moveTo(x, midY);

    while (x < endX + waveLength) {
      // First curve: up
      path.quadraticBezierTo(
        x + waveLength / 4,
        midY - waveHeight,
        x + waveLength / 2,
        midY,
      );

      x += waveLength / 2;

      // Second curve: down
      path.quadraticBezierTo(
        x + waveLength / 4,
        midY + waveHeight,
        x + waveLength / 2,
        midY,
      );

      x += waveLength / 2;
    }

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) =>
      old.phase != phase ||
      old.color != color ||
      old.thickness != thickness ||
      old.indent != indent ||
      old.endIndent != endIndent;
}
