import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';
import 'dart:math' as math;

class CurrentValuePainter extends CustomPainter {
  final CircularSliderSettings settings;
  final CircularSliderValues values;
  final double angle;

  double currentAngle;
  Paint currentValuePaint;

  CurrentValuePainter(
    this.settings,
    this.values,
    this.angle,
  ) {
    currentAngle = settings.features.counterClockwise ? -angle : angle;
    currentValuePaint = Paint()..color = settings.colors.dotColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset handler = degreesToCoordinates(
      values.center,
      -math.pi / 2 + values.startAngle + currentAngle + 1.5,
      values.radius,
    );
    canvas.drawCircle(
      handler,
      values.handlerSize,
      currentValuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
