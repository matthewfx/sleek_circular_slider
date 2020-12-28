class CircularSliderFeatures {
  final bool hideShadow;
  final bool animationEnabled;
  final bool spinnerMode;
  final bool counterClockwise;

  const CircularSliderFeatures({
    this.hideShadow = CircularSliderDefaultFeatures.hideShadow,
    this.animationEnabled = CircularSliderDefaultFeatures.animationEnabled,
    this.spinnerMode = CircularSliderDefaultFeatures.spinnerMode,
    this.counterClockwise = CircularSliderDefaultFeatures.counterClockwise,
  });
}

class CircularSliderDefaultFeatures {
  static const bool hideShadow = false;
  static const bool animationEnabled = true;
  static const bool counterClockwise = false;
  static const bool spinnerMode = false;
}
