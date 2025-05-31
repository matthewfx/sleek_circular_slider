// Helper classes for better organization of curve painter configurations.
class ShadowConfig {
  final double step;
  final double maxOpacity;
  final int repetitions;
  final double opacityStep;

  const ShadowConfig({
    required this.step,
    required this.maxOpacity,
    required this.repetitions,
    required this.opacityStep,
  });
}

class GradientConfig {
  final double rotationAngle;
  final double startAngle;
  final double endAngle;

  const GradientConfig({
    required this.rotationAngle,
    required this.startAngle,
    required this.endAngle,
  });
}

class ArcConfig {
  final double startAngle;
  final double sweepAngle;

  const ArcConfig({required this.startAngle, required this.sweepAngle});
}
