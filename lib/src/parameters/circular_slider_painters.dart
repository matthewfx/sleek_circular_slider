import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/src/painters/background_painter.dart';
import 'package:sleek_circular_slider/src/painters/current_value_painter.dart';
import 'package:sleek_circular_slider/src/painters/progress_bar_painter.dart';
import 'package:sleek_circular_slider/src/painters/shadow_painter.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_values.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_settings.dart';

typedef CustomPainter CustomSliderPainter(
  CircularSliderSettings settings,
  CircularSliderValues values,
);

class CircularSliderPainters {
  CustomSliderPainter backgroundPainter;
  CustomSliderPainter shadowPainter;
  CustomSliderPainter progressBarPainter;
  CustomSliderPainter currentValuePainter;

  CircularSliderPainters({
    CustomSliderPainter backgroundPainter,
    CustomSliderPainter shadowPainter,
    CustomSliderPainter progressBarPainter,
    CustomSliderPainter currentValuePainter,
  })  : this.backgroundPainter = backgroundPainter ??
            ((settings, values) => BackgroundPainter(settings, values)),
        this.shadowPainter = shadowPainter ??
            ((settings, values) => ShadowPainter(settings, values)),
        this.progressBarPainter = progressBarPainter ??
            ((settings, values) => ProgressBarPainter(settings, values)),
        this.currentValuePainter = currentValuePainter ??
            ((settings, values) => CurrentValuePainter(settings, values));
}
