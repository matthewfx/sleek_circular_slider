import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';

abstract class ShapePainter {
  void drawShape(
    Canvas canvas,
    Size size,
    Paint paint, {
    bool ignoreAngle = false,
    bool spinnerMode = false,
  });
}

class CircularArcPainter extends ShapePainter {
  final CircularSliderSettings settings;
  final CircularSliderValues values;

  CircularArcPainter(
    this.settings,
    this.values,
  );

  @override
  void drawShape(
    Canvas canvas,
    Size size,
    Paint paint, {
    bool ignoreAngle = false,
    bool spinnerMode = false,
  }) {
    final double angleValue =
        ignoreAngle ? 0 : (values.angleRange - values.currentAngle);
    final range = settings.features.counterClockwise
        ? -values.angleRange
        : values.angleRange;
    final currentAngle =
        settings.features.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(
          center: values.center,
          radius: values.radius,
        ),
        degreeToRadians(spinnerMode ? 0 : values.startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }
}
