import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';

class ProgressBarPainter extends CustomPainter {
  final CircularSliderSettings settings;
  final CircularSliderValues values;
  final CircularArcPainter circularArcPainter;

  double currentAngle;
  double gradientRotationAngle;
  double gradientStartAngle;
  double gradientEndAngle;
  List<Color> colors;
  GradientRotation rotation;
  Gradient gradient;
  Paint progressBarPaint;

  ProgressBarPainter(
    this.settings,
    this.values,
    this.circularArcPainter,
  ) {
    currentAngle = settings.features.counterClockwise
        ? -values.currentAngle
        : values.currentAngle;

    gradientRotationAngle = settings.colors.dynamicGradient
        ? settings.features.counterClockwise
            ? values.startAngle + 10.0
            : values.startAngle - 10.0
        : 0.0;

    gradientStartAngle = settings.colors.dynamicGradient
        ? settings.features.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : settings.colors.barGradientStartAngle;

    gradientEndAngle = settings.colors.dynamicGradient
        ? settings.features.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : settings.colors.barGradientEndAngle;

    rotation = GradientRotation(degreeToRadians(gradientRotationAngle));

    colors =
        settings.colors.dynamicGradient && settings.features.counterClockwise
            ? settings.colors.barColors.reversed.toList()
            : settings.colors.barColors;

    gradient = kIsWeb
        ? LinearGradient(tileMode: TileMode.mirror, colors: colors)
        : SweepGradient(
            transform: rotation,
            startAngle: degreeToRadians(gradientStartAngle),
            endAngle: degreeToRadians(gradientEndAngle),
            tileMode: TileMode.mirror,
            colors: colors,
          );

    progressBarPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = values.progressBarWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final sliderRectangle = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    progressBarPaint..shader = gradient.createShader(sliderRectangle);

    circularArcPainter.drawCircularArc(
      canvas,
      size,
      progressBarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
