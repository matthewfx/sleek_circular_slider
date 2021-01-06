import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:math' as math;

import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';

class ShadowPainter extends CustomPainter {
  final CircularSliderSettings settings;
  final CircularSliderValues values;

  double shadowWidth;
  double shadowStep;
  double maxOpacity;
  int repetitions;
  double opacityStep;

  ShapePainter shapePainter;
  Paint shadowPaint;

  ShadowPainter(
    this.settings,
    this.values,
  ) {
    shadowWidth = settings.shadow.getShadowWidth(values.progressBarWidth);

    shadowStep = settings.shadow.step != null
        ? settings.shadow.step
        : math.max(1, (shadowWidth - values.progressBarWidth) / 10);

    maxOpacity = math.min(1.0, settings.shadow.maxOpacity);

    repetitions =
        math.max(1, (shadowWidth - values.progressBarWidth) ~/ shadowStep);

    opacityStep = maxOpacity / repetitions;

    shadowPaint = Paint()
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
