import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart';

class ScoreCircularProgress extends CustomPainter {
  const ScoreCircularProgress(
      {required this.backColor,
      required this.frontColor,
      required this.strokeWidth,
      required this.value});
  final Color backColor, frontColor;
  final double strokeWidth, value;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint1 = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final paint2 = Paint()
      ..strokeWidth = strokeWidth
      ..color = frontColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final r =
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h);
    canvas.drawArc(r, radians(180), radians(180), false, paint1);
    canvas.drawArc(r, radians(180), radians(180 * value), false, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
