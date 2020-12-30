class CircularSliderGeometry {
  final double size;
  final double startAngle;
  final double angleRange;

  final double _trackWidth;
  double get trackWidth => _trackWidth ?? progressBarWidth / 4.0;

  final double _progressBarWidth;
  double get progressBarWidth => _progressBarWidth ?? size / 10.0;

  final double _handlerSize;
  double get handlerSize => _handlerSize ?? progressBarWidth / 5.0;

  final double _shadowWidth;
  double get shadowWidth => _shadowWidth ?? progressBarWidth * 1.4;

  const CircularSliderGeometry({
    this.size = DefaultGeometry.size,
    this.startAngle = DefaultGeometry.startAngle,
    this.angleRange = DefaultGeometry.angleRange,
    double trackWidth,
    double progressBarWidth,
    double handlerSize,
    double shadowWidth,
  })  : _trackWidth = trackWidth,
        _progressBarWidth = progressBarWidth,
        _handlerSize = handlerSize,
        _shadowWidth = shadowWidth;
}

class DefaultGeometry {
  static const double size = 150;
  static const double startAngle = 150;
  static const double angleRange = 240;
}
