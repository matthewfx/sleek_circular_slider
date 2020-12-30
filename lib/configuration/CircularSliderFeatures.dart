class CircularSliderFeatures {
  final bool hideShadow;
  final bool animationEnabled;
  final bool spinnerMode;
  final bool counterClockwise;

  const CircularSliderFeatures({
    this.hideShadow = DefaultFeatures.hideShadow,
    this.animationEnabled = DefaultFeatures.animationEnabled,
    this.spinnerMode = DefaultFeatures.spinnerMode,
    this.counterClockwise = DefaultFeatures.counterClockwise,
  });
}

class DefaultFeatures {
  static const bool hideShadow = false;
  static const bool animationEnabled = true;
  static const bool counterClockwise = false;
  static const bool spinnerMode = false;
}
