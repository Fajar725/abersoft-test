import 'package:abersoft_test/const/custom_color.dart';
import 'package:flutter/material.dart';

class CircleBlurPainter extends CustomPainter {

  double blurSigma;

  CircleBlurPainter({required this.blurSigma});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = textWhite
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawOval(Rect.fromCenter(center: center, width: size.width, height: size.height), line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}