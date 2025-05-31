part of 'circular_slider.dart';

class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderAppearance appearance;
  final double startAngle;
  final double angleRange;

  Offset? center;
  double? radius;
  Rect? progressBarRect;

  _CurvePainter({
    required this.appearance,
    this.angle = 30,
    required this.startAngle,
    required this.angleRange,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _initializeDimensions(size);
    _drawTrack(canvas, size);
    _drawShadow(canvas, size);
    _drawProgressBar(canvas, size);
    _drawHandler(canvas);
  }

  void _initializeDimensions(Size size) {
    radius =
        math.min(size.width / 2, size.height / 2) -
        appearance.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);
    progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
  }

  void _drawTrack(Canvas canvas, Size size) {
    final trackPaint = _createTrackPaint();
    _drawCircularArc(
      canvas: canvas,
      size: size,
      paint: trackPaint,
      ignoreAngle: true,
      spinnerMode: appearance.spinnerMode,
    );
  }

  Paint _createTrackPaint() {
    final paint =
        Paint()
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = appearance.trackWidth;

    if (appearance.trackColors != null) {
      final gradient = SweepGradient(
        startAngle: degreeToRadians(appearance.trackGradientStartAngle),
        endAngle: degreeToRadians(appearance.trackGradientStopAngle),
        tileMode: TileMode.mirror,
        colors: appearance.trackColors!,
      );
      paint.shader = gradient.createShader(progressBarRect!);
    } else {
      paint.color = appearance.trackColor;
    }

    return paint;
  }

  void _drawShadow(Canvas canvas, Size size) {
    if (appearance.hideShadow) return;

    final shadowConfig = _calculateShadowConfig();
    final shadowPaint =
        Paint()
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    for (int i = 1; i <= shadowConfig.repetitions; i++) {
      shadowPaint
        ..strokeWidth = appearance.progressBarWidth + i * shadowConfig.step
        ..color = appearance.shadowColor.withValues(
          alpha: shadowConfig.maxOpacity - (shadowConfig.opacityStep * (i - 1)),
        );

      _drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  _ShadowConfig _calculateShadowConfig() {
    final step =
        appearance.shadowStep ??
        math.max(
          1.0,
          (appearance.shadowWidth - appearance.progressBarWidth) / 10,
        );
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(
      1,
      ((appearance.shadowWidth - appearance.progressBarWidth) / step).round(),
    );
    final opacityStep = maxOpacity / repetitions;

    return _ShadowConfig(
      step: step,
      maxOpacity: maxOpacity,
      repetitions: repetitions,
      opacityStep: opacityStep,
    );
  }

  void _drawProgressBar(Canvas canvas, Size size) {
    final progressBarPaint =
        Paint()
          ..shader = _createProgressBarGradient().createShader(progressBarRect!)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = appearance.progressBarWidth;

    _drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);
  }

  Gradient _createProgressBarGradient() {
    if (kIsWeb) {
      return LinearGradient(
        tileMode: TileMode.mirror,
        colors: _getGradientColors(),
      );
    }

    final gradientConfig = _calculateGradientConfig();
    return SweepGradient(
      transform: GradientRotation(
        degreeToRadians(gradientConfig.rotationAngle),
      ),
      startAngle: degreeToRadians(gradientConfig.startAngle),
      endAngle: degreeToRadians(gradientConfig.endAngle),
      tileMode: TileMode.mirror,
      colors: _getGradientColors(),
    );
  }

  _GradientConfig _calculateGradientConfig() {
    final currentAngle = _getCurrentAngle();
    final isDynamic = appearance.dynamicGradient;
    final isCounterClockwise = appearance.counterClockwise;

    final rotationAngle =
        isDynamic
            ? (isCounterClockwise ? startAngle + 10.0 : startAngle - 10.0)
            : 0.0;

    final gradientStartAngle =
        isDynamic
            ? (isCounterClockwise ? 360.0 - currentAngle.abs() : 0.0)
            : appearance.gradientStartAngle;

    final gradientEndAngle =
        isDynamic
            ? (isCounterClockwise ? 360.0 : currentAngle.abs())
            : appearance.gradientStopAngle;

    return _GradientConfig(
      rotationAngle: rotationAngle,
      startAngle: gradientStartAngle,
      endAngle: gradientEndAngle,
    );
  }

  List<Color> _getGradientColors() {
    final shouldReverse =
        appearance.dynamicGradient && appearance.counterClockwise;
    return shouldReverse
        ? appearance.progressBarColors.reversed.toList()
        : appearance.progressBarColors;
  }

  void _drawHandler(Canvas canvas) {
    final handlerPaint = Paint()..color = appearance.dotColor;
    final handlerPosition = _calculateHandlerPosition();
    canvas.drawCircle(handlerPosition, appearance.handlerSize, handlerPaint);
  }

  Offset _calculateHandlerPosition() {
    final currentAngle = _getCurrentAngle();
    return degreesToCoordinates(
      center!,
      -math.pi / 2 + startAngle + currentAngle + 1.5,
      radius!,
    );
  }

  double _getCurrentAngle() {
    return appearance.counterClockwise ? -angle : angle;
  }

  void _drawCircularArc({
    required Canvas canvas,
    required Size size,
    required Paint paint,
    bool ignoreAngle = false,
    bool spinnerMode = false,
  }) {
    final arcConfig = _calculateArcConfig(ignoreAngle, spinnerMode);

    canvas.drawArc(
      Rect.fromCircle(center: center!, radius: radius!),
      degreeToRadians(arcConfig.startAngle),
      degreeToRadians(arcConfig.sweepAngle),
      false,
      paint,
    );
  }

  _ArcConfig _calculateArcConfig(bool ignoreAngle, bool spinnerMode) {
    if (spinnerMode) {
      return _ArcConfig(startAngle: 0, sweepAngle: 360);
    }

    final angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = appearance.counterClockwise ? -angleRange : angleRange;
    final currentAngle = appearance.counterClockwise ? angleValue : -angleValue;

    return _ArcConfig(startAngle: startAngle, sweepAngle: range + currentAngle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Helper classes for better organization
class _ShadowConfig {
  final double step;
  final double maxOpacity;
  final int repetitions;
  final double opacityStep;

  const _ShadowConfig({
    required this.step,
    required this.maxOpacity,
    required this.repetitions,
    required this.opacityStep,
  });
}

class _GradientConfig {
  final double rotationAngle;
  final double startAngle;
  final double endAngle;

  const _GradientConfig({
    required this.rotationAngle,
    required this.startAngle,
    required this.endAngle,
  });
}

class _ArcConfig {
  final double startAngle;
  final double sweepAngle;

  const _ArcConfig({required this.startAngle, required this.sweepAngle});
}
