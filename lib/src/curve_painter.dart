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

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    Paint trackPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = settings.geometry.trackWidth;

    if (settings.colors.trackColors != null) {
      final trackGradient = SweepGradient(
        startAngle: degreeToRadians(settings.colors.trackGradientStartAngle),
        endAngle: degreeToRadians(settings.colors.trackGradientEndAngle),
        tileMode: TileMode.mirror,
        colors: settings.colors.trackColors,
      );
      trackPaint..shader = trackGradient.createShader(progressBarRect);
    } else {
      trackPaint..color = settings.colors.trackColor;
    }
    drawCircularArc(
        canvas: canvas,
        size: size,
        paint: trackPaint,
        ignoreAngle: true,
        spinnerMode: settings.features.spinnerMode);

    if (!settings.features.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final currentAngle = settings.features.counterClockwise ? -angle : angle;

    final gradientRotationAngle = settings.colors.dynamicGradient
        ? settings.features.counterClockwise
            ? startAngle + 10.0
            : startAngle - 10.0
        : 0.0;

    final gradientStartAngle = settings.colors.dynamicGradient
        ? settings.features.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : settings.colors.barGradientStartAngle;
    final gradientEndAngle = settings.colors.dynamicGradient
        ? settings.features.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : settings.colors.barGradientEndAngle;

    final GradientRotation rotation =
        GradientRotation(degreeToRadians(gradientRotationAngle));

    final colors =
        settings.colors.dynamicGradient && settings.features.counterClockwise
            ? settings.colors.barColors.reversed.toList()
            : settings.colors.barColors;

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
      ..strokeWidth = settings.geometry.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

    var dotPaint = Paint()..color = settings.colors.dotColor;

    Offset handler = degreesToCoordinates(
        center, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);
    canvas.drawCircle(handler, settings.geometry.handlerSize, dotPaint);
  }

  drawCircularArc(
      {@required Canvas canvas,
      @required Size size,
      @required Paint paint,
      bool ignoreAngle = false,
      bool spinnerMode = false}) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = settings.features.counterClockwise ? -angleRange : angleRange;
    final currentAngle =
        settings.features.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(spinnerMode ? 0 : startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }

  drawShadow({@required Canvas canvas, @required Size size}) {
    final shadowStep = settings.shadowStep != null
        ? settings.shadowStep
        : math.max(
            1,
            (settings.geometry.shadowWidth -
                    settings.geometry.progressBarWidth) ~/
                10);
    final maxOpacity = math.min(1.0, settings.shadowMaxOpacity);
    final repetitions = math.max(
        1,
        ((settings.geometry.shadowWidth - settings.geometry.progressBarWidth) ~/
            shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth =
          settings.geometry.progressBarWidth + i * shadowStep;
      shadowPaint.color = settings.colors.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
