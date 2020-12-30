class CircularSliderGeometry {
  final double size;
  final double startAngle;
  final double angleRange;

  final double _progressBarWidth;
  double get progressBarWidth =>
      _progressBarWidth ?? DefaultGeometry.progressBarWidth(size);

  final double _trackWidth;
  double get trackWidth =>
      _trackWidth ?? DefaultGeometry.trackWidth(progressBarWidth);

  final double _handlerSize;
  double get handlerSize =>
      _handlerSize ?? DefaultGeometry.handlerSize(progressBarWidth);

  final double _shadowWidth;
  double get shadowWidth =>
      _shadowWidth ?? DefaultGeometry.shadowWidth(progressBarWidth);

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

  static double progressBarWidth(double size) => size / 10.0;
  static double trackWidth(double progressBarWidth) => progressBarWidth / 4.0;
  static double handlerSize(double progressBarWidth) => progressBarWidth / 5.0;
  static double shadowWidth(double progressBarWidth) => progressBarWidth * 1.4;
}
