import 'package:sleek_circular_slider/src/settings/CircularSliderColors.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderFeatures.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderShadow.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderText.dart';

class CircularSliderSettings {
  final CircularSliderColors colors;
  final CircularSliderFeatures features;
  final CircularSliderText text;
  final CircularSliderShadow shadow;

  const CircularSliderSettings({
    this.colors = const CircularSliderColors(),
    this.features = const CircularSliderFeatures(),
    this.text = const CircularSliderText(),
    this.shadow = const CircularSliderShadow(),
  });
}
