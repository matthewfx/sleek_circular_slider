part of circular_slider;

class _CurvePainter extends CustomPainter {
  final CustomPainter backgroundPainter;
  final CustomPainter shadowPainter;
  final CustomPainter currentValuePainter;
  final CustomPainter progressBarPainter;
  final CircularSliderSettings settings;
  final CircularSliderValues values;

  _CurvePainter({
    required this.backgroundPainter,
    required this.shadowPainter,
    required this.progressBarPainter,
    required this.currentValuePainter,
    required this.settings,
    required this.values,
  });

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
