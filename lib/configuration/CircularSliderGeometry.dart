class CircularSliderGeometry {
  final double size;
  final double startAngle;
  final double angleRange;

  const CircularSliderGeometry({
    this.size = CircularSliderDefaultGeometry.size,
    this.startAngle = CircularSliderDefaultGeometry.startAngle,
    this.angleRange = CircularSliderDefaultGeometry.angleRange,
  });
}

class CircularSliderDefaultGeometry {
  static const double size = 150;
  static const double startAngle = 150;
  static const double angleRange = 240;
}
