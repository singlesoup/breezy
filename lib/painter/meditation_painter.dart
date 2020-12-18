import 'package:flutter/material.dart';

class MeditationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    final width = size.width;
    final height = size.height;

    paint.color = Colors.blue[200];
    canvas.drawCircle(
        Offset(width * .72, height * .84), width - (width * .62), paint);

    paint.color = Colors.blue[300];
    canvas.drawCircle(
        Offset(width * .5, height * .82), width - (width * .60), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
