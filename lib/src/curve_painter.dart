part of circular_slider;

class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderSettings appearance;
  final startAngle;
  final angleRange;

  Offset handler;
  Offset center;
  double radius;

  _CurvePainter({
    this.appearance,
    this.angle = 30,
    this.startAngle,
    this.angleRange,
  })  : assert(appearance != null),
        assert(startAngle != null),
        assert(angleRange != null);

  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        appearance.geometry.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    Paint trackPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.geometry.trackWidth;

    if (appearance.colors.trackColors != null) {
      final trackGradient = SweepGradient(
        startAngle: degreeToRadians(appearance.trackGradientStartAngle),
        endAngle: degreeToRadians(appearance.trackGradientStopAngle),
        tileMode: TileMode.mirror,
        colors: appearance.colors.trackColors,
      );
      trackPaint..shader = trackGradient.createShader(progressBarRect);
    } else {
      trackPaint..color = appearance.colors.trackColor;
    }
    drawCircularArc(
        canvas: canvas,
        size: size,
        paint: trackPaint,
        ignoreAngle: true,
        spinnerMode: appearance.features.spinnerMode);

    if (!appearance.features.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final currentAngle = appearance.features.counterClockwise ? -angle : angle;

    final gradientRotationAngle = appearance.dynamicGradient
        ? appearance.features.counterClockwise
            ? startAngle + 10.0
            : startAngle - 10.0
        : 0.0;

    final gradientStartAngle = appearance.dynamicGradient
        ? appearance.features.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : appearance.gradientStartAngle;
    final gradientEndAngle = appearance.dynamicGradient
        ? appearance.features.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : appearance.gradientStopAngle;

    final GradientRotation rotation =
        GradientRotation(degreeToRadians(gradientRotationAngle));

    final colors =
        appearance.dynamicGradient && appearance.features.counterClockwise
            ? appearance.colors.barColors.reversed.toList()
            : appearance.colors.barColors;

    final progressBarGradient = kIsWeb
        ? LinearGradient(
            tileMode: TileMode.mirror,
            colors: colors,
          )
        : SweepGradient(
            transform: rotation,
            startAngle: degreeToRadians(gradientStartAngle),
            endAngle: degreeToRadians(gradientEndAngle),
            tileMode: TileMode.mirror,
            colors: colors,
          );

    final progressBarPaint = Paint()
      ..shader = progressBarGradient.createShader(progressBarRect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.geometry.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

    var dotPaint = Paint()..color = appearance.colors.dotColor;

    Offset handler = degreesToCoordinates(
        center, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);
    canvas.drawCircle(handler, appearance.geometry.handlerSize, dotPaint);
  }

  drawCircularArc(
      {@required Canvas canvas,
      @required Size size,
      @required Paint paint,
      bool ignoreAngle = false,
      bool spinnerMode = false}) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range =
        appearance.features.counterClockwise ? -angleRange : angleRange;
    final currentAngle =
        appearance.features.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(spinnerMode ? 0 : startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }

  drawShadow({@required Canvas canvas, @required Size size}) {
    final shadowStep = appearance.shadowStep != null
        ? appearance.shadowStep
        : math.max(
            1,
            (appearance.geometry.shadowWidth -
                    appearance.geometry.progressBarWidth) ~/
                10);
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(
        1,
        ((appearance.geometry.shadowWidth -
                appearance.geometry.progressBarWidth) ~/
            shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth =
          appearance.geometry.progressBarWidth + i * shadowStep;
      shadowPaint.color = appearance.colors.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
