import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_values.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';

class BackgroundPainter extends CustomPainter {
  final CircularSliderSettings settings;
  final CircularSliderValues values;

  late ShapePainter shapePainter;
  late Paint backgroundPaint;

  BackgroundPainter(
    this.settings,
    this.values,
  ) {
    backgroundPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = values.trackWidth;

    shapePainter = CircularArcPainter(
      settings,
      values,
    );
  }

  @override
  paint(Canvas canvas, Size size) {
    final sliderRectangle = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    setupColorOrGradient(sliderRectangle);

    shapePainter.drawShape(
      canvas,
      size,
      backgroundPaint,
      ignoreAngle: true,
      spinnerMode: settings.features.spinnerMode,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  setupColorOrGradient(Rect sliderRectangle) {
    if (settings.colors.trackColors != null) {
      final backgroundGradient = SweepGradient(
        startAngle: degreeToRadians(settings.colors.trackGradientStartAngle),
        endAngle: degreeToRadians(settings.colors.trackGradientEndAngle),
        tileMode: TileMode.mirror,
        colors: settings.colors.trackColors!,
      );
      backgroundPaint
        ..shader = backgroundGradient.createShader(sliderRectangle);
    } else {
      backgroundPaint..color = settings.colors.trackColor;
    }
  }
}
