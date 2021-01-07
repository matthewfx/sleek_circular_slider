import 'package:sleek_circular_slider/src/settings/circular_slider_colors.dart';
import 'package:sleek_circular_slider/src/settings/circular_slider_features.dart';
import 'package:sleek_circular_slider/src/settings/circular_slider_shadow.dart';
import 'package:sleek_circular_slider/src/settings/circular_slider_text.dart';

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
