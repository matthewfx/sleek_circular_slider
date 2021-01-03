import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';

class CircularArcPainter {
  final CircularSliderSettings settings;
  final double angle;
  final double startAngle;
  final double angleRange;
  final Offset center;
  final double radius;

  CircularArcPainter(
    this.settings,
    this.angle,
    this.startAngle,
    this.angleRange,
    this.center,
    this.radius,
  );
  void drawCircularArc(
    Canvas canvas,
    Size size,
    Paint paint, {
    bool ignoreAngle = false,
    bool spinnerMode = false,
  }) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = settings.features.counterClockwise ? -angleRange : angleRange;
    final currentAngle =
        settings.features.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(spinnerMode ? 0 : startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }
}
