import 'package:sleek_circular_slider/src/settings/CircularSliderColors.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderFeatures.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderGeometry.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderShadow.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderText.dart';

class CircularSliderSettings {
  final CircularSliderGeometry geometry;
  final CircularSliderColors colors;
  final CircularSliderFeatures features;
  final CircularSliderText text;
  final CircularSliderShadow shadow;

  const CircularSliderSettings({
    this.geometry = const CircularSliderGeometry(),
    this.colors = const CircularSliderColors(),
    this.features = const CircularSliderFeatures(),
    this.text = const CircularSliderText(),
    this.shadow = const CircularSliderShadow(),
  });
}
