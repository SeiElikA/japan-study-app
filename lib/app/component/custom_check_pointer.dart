import 'dart:math';

import 'package:flutter/material.dart';
import 'package:japan_study_app/config/theme/color.dart';

class CheckPointPainter extends CustomPainter {
  double pointRadius = 3;
  double radius = 24;

  Offset offset;

  CheckPointPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill;
    paint.color = MyColor.mainColor;

    double startAngle = -pi / 2;
    double sweepAngle = pi;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(offset.dx, offset.dy), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint);

    paint.color = MyColor.secondaryColor;
    canvas.drawCircle(
        Offset(offset.dx - pointRadius / 2, offset.dy ),
        pointRadius,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
