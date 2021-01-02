import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/unit_conversions.dart';
import 'dart:math' as math;

class CurrentValuePainter extends CustomPainter {
  final CircularSliderSettings settings;
  final double angle;
  final double startAngle;
  final Offset center;
  final double radius;

  double currentAngle;
  Paint currentValuePaint;

  CurrentValuePainter(
    this.settings,
    this.angle,
    this.startAngle,
    this.center,
    this.radius,
  ) {
    currentAngle = settings.features.counterClockwise ? -angle : angle;

    currentValuePaint = Paint()..color = settings.colors.dotColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset handler = degreesToCoordinates(
      center,
      -math.pi / 2 + startAngle + currentAngle + 1.5,
      radius,
    );
    canvas.drawCircle(
      handler,
      settings.geometry.handlerSize,
      currentValuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
