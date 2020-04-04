import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class DefaultPaint extends CustomPainter {





  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    final gradient = new LinearGradient(colors: [
      Color.fromRGBO(163, 215, 221,1),
      Colors.white.withOpacity(1),
    ],begin: Alignment.topCenter,end: Alignment.bottomCenter);

    var rect = Offset.zero & size;

    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}