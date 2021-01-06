import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/painters/background_painter.dart';
import 'package:sleek_circular_slider/src/painters/shadow_painter.dart';

typedef void OnChange(double value);
typedef Widget InnerWidget(double percentage);
typedef CustomPainter CustomSliderPainter(
  CircularSliderSettings settings,
  CircularSliderValues values,
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
            ((settings, values) => BackgroundPainter(settings, values)),
        this.shadowPainter = shadowPainter ??
            ((settings, values) => ShadowPainter(settings, values)),
        this.progressBarPainter = progressBarPainter ??
            ((settings, values) => ProgressBarPainter(settings, values)),
        this.currentValuePainter = currentValuePainter ??
            ((settings, values) => CurrentValuePainter(settings, values));
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
