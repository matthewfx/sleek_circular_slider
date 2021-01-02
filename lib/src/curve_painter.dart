part of circular_slider;

class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderSettings settings;
  final startAngle;
  final angleRange;

  Offset handler;
  Offset center;
  double radius;

  _CurvePainter({
    this.settings,
    this.angle = 30,
    this.startAngle,
    this.angleRange,
  })  : assert(settings != null),
        assert(startAngle != null),
        assert(angleRange != null);

  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        settings.geometry.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final circularArcPainter = CircularArcPainter(
      settings,
      angle,
      startAngle,
      angleRange,
      center,
      radius,
    );

    final backgroundPainter = BackgroundPainter(
      settings,
      circularArcPainter,
    );
    final shadowPainter = ShadowPainter(
      settings,
      circularArcPainter,
    );
    final progressBarPainter = ProgressBarPainter(
      settings,
      circularArcPainter,
      angle,
      startAngle,
    );
    final currentValuePainter = CurrentValuePainter(
      settings,
      angle,
      startAngle,
      center,
      radius,
    );

    backgroundPainter.paint(canvas, size);
    shadowPainter.paint(canvas, size);
    progressBarPainter.paint(canvas, size);
    currentValuePainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
