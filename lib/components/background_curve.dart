import 'dart:math' as math;

import 'package:flutter/material.dart';

class BackgroundCurve extends StatelessWidget {
  const BackgroundCurve({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvePainter(),
      child: Container(
        height: 300,
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const angle = -math.pi / 4;
    Color paintColor = const Color(0xff3A98B9);
    Paint circlePaint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    canvas.save();
    canvas.translate(size.width * 0.4, size.height * 0.2);
    canvas.rotate(angle);
    canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 420, height: 550),
        circlePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
