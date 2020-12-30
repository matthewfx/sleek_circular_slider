import 'package:sleek_circular_slider/configuration/CircularSliderColors.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderFeatures.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderGeometry.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderText.dart';

class CircularSliderSettings {
  static const defaultGeometry = CircularSliderGeometry();
  static const defaultColors = CircularSliderColors();
  static const defaultFeatures = CircularSliderFeatures();
  static const defaultText = CircularSliderText();

  final CircularSliderGeometry geometry;
  final CircularSliderColors colors;
  final CircularSliderFeatures features;
  final CircularSliderText text;

  static const double _defaultShadowMaxOpacity = 0.2;
  double get shadowMaxOpacity =>
      customColors?.shadowMaxOpacity ?? _defaultShadowMaxOpacity;
  double get shadowStep => customColors?.shadowStep;

  final double animDurationMultiplier;
  final int spinnerDuration;
  final CustomSliderColors customColors;

  const CircularSliderSettings({
    this.geometry = defaultGeometry,
    this.colors = defaultColors,
    this.features = defaultFeatures,
    this.text = defaultText,
    this.customColors,
    this.spinnerDuration = 1500,
    this.animDurationMultiplier = 1.0,
  });
}

class CustomSliderColors {
  final double shadowMaxOpacity;
  final double shadowStep;

  CustomSliderColors({
    this.shadowMaxOpacity,
    this.shadowStep,
  });
}
