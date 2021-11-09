import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:math' as math;

import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';
import 'package:sleek_circular_slider/src/painters/shape_painter.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_values.dart';

class ShadowPainter extends CustomPainter {
  final CircularSliderSettings settings;
  final CircularSliderValues values;

  late double shadowWidth;
  late double shadowStep;
  late double maxOpacity;
  late int repetitions;
  late double opacityStep;

  late ShapePainter shapePainter;
  late Paint shadowPaint;

  ShadowPainter(
    this.settings,
    this.values,
  ) {
    shadowWidth = settings.shadow.getShadowWidth(values.progressBarWidth);

    shadowStep = settings.shadow.step ??
        math.max(1, (shadowWidth - values.progressBarWidth) / 10);

    maxOpacity = math.min(1.0, settings.shadow.maxOpacity);

    repetitions =
        math.max(1, (shadowWidth - values.progressBarWidth) ~/ shadowStep);

    opacityStep = maxOpacity / repetitions;

    this.shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    shapePainter = CircularArcPainter(
      settings,
      values,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (settings.shadow.hideShadow) return;

    for (int i = 1; i <= repetitions; i++) {
      final currentWidth = values.progressBarWidth + i * shadowStep;
      final currentOpacity = maxOpacity - (opacityStep * (i - 1));

      shadowPaint.strokeWidth = currentWidth;
      shadowPaint.color = settings.shadow.color.withOpacity(currentOpacity);

      shapePainter.drawShape(canvas, size, shadowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
