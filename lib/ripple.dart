import 'package:flutter/material.dart';

// --- Custom Painter for the Ripple Effect ---
class RipplePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  RipplePainter({required this.animation, required this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      _drawWave(canvas, rect, wave);
    }
  }

  void _drawWave(Canvas canvas, Rect rect, int wave) {
    final double opacity = (1.0 - (animation.value / 3)).clamp(0.0, 1.0);
    // ignore: deprecated_member_use
    final Color waveColor = color.withOpacity(opacity);
    final double waveValue = animation.value * (1 + (wave * 0.1));
    final double scale = 1.0 + waveValue;
    final double width = rect.width * 0.5 * scale;
    final double height = rect.height * 0.5 * scale;
    final Paint paint = Paint()..color = waveColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: rect.center, width: width, height: height * 1.2),
        const Radius.circular(20),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) => true;
}
