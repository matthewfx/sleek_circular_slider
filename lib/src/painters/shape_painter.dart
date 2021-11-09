import 'package:flutter/material.dart';

abstract class ShapePainter {
  void drawShape(
    Canvas canvas,
    Size size,
    Paint paint, {
    bool ignoreAngle = false,
    bool spinnerMode = false,
  });
}
