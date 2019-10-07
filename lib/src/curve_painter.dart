part of circular_slider;

class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderAppearance appearance;

  Offset handler;
  Offset center;
  double radius;

  _CurvePainter({this.appearance, this.angle = 30});

  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        appearance.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final trackPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.trackWidth
      ..color = appearance.trackColor;
    drawCircularArc(
        canvas: canvas, size: size, paint: trackPaint, ignoreAngle: true);

    if (!appearance.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final progressBarGradient = SweepGradient(
      startAngle: degreeToRadians(appearance.gradientStartAngle),
      endAngle: degreeToRadians(appearance.gradientStopAngle),
      tileMode: TileMode.mirror,
      colors: appearance.progressBarColors,
    );

    final progressBarPaint = Paint()
      ..shader = progressBarGradient.createShader(progressBarRect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

    var dotPaint = Paint()..color = appearance.dotColor;

    Offset handler = degreesToCoordinates(
        center, -math.pi / 2 + appearance.startAngle + angle + 1.5, radius);
    canvas.drawCircle(handler, appearance.handlerSize, dotPaint);
  }

  drawCircularArc(
      {@required Canvas canvas,
      @required Size size,
      @required Paint paint,
      bool ignoreAngle = false}) {
    final double angleValue = ignoreAngle ? 0 : (appearance.angleRange - angle);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(appearance.startAngle),
        degreeToRadians(appearance.angleRange - angleValue),
        false,
        paint);
  }

  drawShadow({@required Canvas canvas, @required Size size}) {
    final shadowStep = appearance.shadowStep != null
        ? appearance.shadowStep
        : math.max(
            1, (appearance.shadowWidth - appearance.progressBarWidth) ~/ 10);
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(1,
        ((appearance.shadowWidth - appearance.progressBarWidth) ~/ shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth = appearance.progressBarWidth + i * shadowStep;
      shadowPaint.color = appearance.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
