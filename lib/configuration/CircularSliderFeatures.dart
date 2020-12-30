class CircularSliderFeatures {
  final bool hideShadow;
  final bool counterClockwise;
  final bool spinnerMode;
  final int spinnerDuration;
  final bool animationEnabled;
  final double animationDurationMultiplier;

  const CircularSliderFeatures({
    this.hideShadow = DefaultFeatures.hideShadow,
    this.counterClockwise = DefaultFeatures.counterClockwise,
    this.spinnerMode = DefaultFeatures.spinnerMode,
    this.spinnerDuration = DefaultFeatures.spinnerDurationInMilliseconds,
    this.animationEnabled = DefaultFeatures.animationEnabled,
    this.animationDurationMultiplier =
        DefaultFeatures.animationDurationMultiplier,
  });
}

class DefaultFeatures {
  static const bool hideShadow = false;
  static const bool counterClockwise = false;
  static const bool spinnerMode = false;
  static const int spinnerDurationInMilliseconds = 1500;
  static const bool animationEnabled = true;
  static const double animationDurationMultiplier = 1.0;
}
