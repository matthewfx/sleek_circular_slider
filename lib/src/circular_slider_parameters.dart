import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/painters/background_painter.dart';
import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';
import 'package:sleek_circular_slider/src/painters/shadow_painter.dart';

typedef void OnChange(double value);
typedef Widget InnerWidget(double percentage);
typedef CustomPainter CustomSliderPainter(
  CircularSliderSettings settings,
  CircularSliderValues values,
  CircularArcPainter circularArcPainter,
  double currentAngle,
);

class SliderPainters {
  CustomSliderPainter backgroundPainter;
  CustomSliderPainter shadowPainter;
  CustomSliderPainter progressBarPainter;
  CustomSliderPainter currentValuePainter;
  SliderPainters({
    CustomSliderPainter backgroundPainter,
    CustomSliderPainter shadowPainter,
    CustomSliderPainter progressBarPainter,
    CustomSliderPainter currentValuePainter,
  })  : this.backgroundPainter = backgroundPainter ??
            ((settings, values, painter, angle) =>
                BackgroundPainter(settings, values, painter)),
        this.shadowPainter = shadowPainter ??
            ((settings, values, painter, angle) =>
                ShadowPainter(settings, values, painter)),
        this.progressBarPainter = progressBarPainter ??
            ((settings, values, painter, angle) =>
                ProgressBarPainter(settings, values, painter, angle)),
        this.currentValuePainter = currentValuePainter ??
            ((settings, values, painter, angle) =>
                CurrentValuePainter(settings, values, angle));
}

class SliderCallbacks {
  final OnChange onChange;
  final OnChange onChangeStart;
  final OnChange onChangeEnd;

  const SliderCallbacks({
    this.onChange,
    this.onChangeStart,
    this.onChangeEnd,
  });
}
