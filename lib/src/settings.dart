import 'package:sleek_circular_slider/configuration/CircularSliderColors.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderFeatures.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderGeometry.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderShadow.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderText.dart';

class CircularSliderSettings {
  static const defaultGeometry = CircularSliderGeometry();
  static const defaultColors = CircularSliderColors();
  static const defaultFeatures = CircularSliderFeatures();
  static const defaultText = CircularSliderText();
  static const defaultShadow = CircularSliderShadow();

  final CircularSliderGeometry geometry;
  final CircularSliderColors colors;
  final CircularSliderFeatures features;
  final CircularSliderText text;
  final CircularSliderShadow shadow;

  final double animDurationMultiplier;
  final int spinnerDuration;

  const CircularSliderSettings({
    this.geometry = defaultGeometry,
    this.colors = defaultColors,
    this.features = defaultFeatures,
    this.text = defaultText,
    this.shadow = defaultShadow,
    this.spinnerDuration = 1500,
    this.animDurationMultiplier = 1.0,
  });
}
