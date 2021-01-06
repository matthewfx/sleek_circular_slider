part of circular_slider;

class _CurvePainter extends CustomPainter {
  final CustomPainter backgroundPainter;
  final CustomPainter shadowPainter;
  final CustomPainter currentValuePainter;
  final CustomPainter progressBarPainter;
  final CircularSliderSettings settings;
  final CircularSliderValues values;

  _CurvePainter({
    this.backgroundPainter,
    this.shadowPainter,
    this.progressBarPainter,
    this.currentValuePainter,
    this.settings,
    this.values,
  }) : assert(settings != null);

  @override
  void paint(Canvas canvas, Size size) {
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
