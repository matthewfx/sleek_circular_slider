import 'package:flutter/material.dart';

class CircularSliderColors {
  final Color trackColor;
  final List<Color> trackColors;
  final Color dotColor;
  final List<Color> barColors;

  final double barGradientStartAngle;
  final double barGradientEndAngle;
  final double trackGradientStartAngle;
  final double trackGradientEndAngle;
  final bool dynamicGradient;

  const CircularSliderColors({
    this.trackColor = DefaultColors.trackColor,
    this.trackColors,
    this.dotColor = DefaultColors.dotColor,
    this.barColors = DefaultColors.barColors,
    this.barGradientStartAngle = DefaultColors.barGradientStartAngle,
    this.barGradientEndAngle = DefaultColors.barGradientEndAngle,
    this.trackGradientStartAngle = DefaultColors.trackGradientStartAngle,
    this.trackGradientEndAngle = DefaultColors.trackGradientEndAngle,
    this.dynamicGradient = DefaultColors.dynamicGradient,
  });
}

class DefaultColors {
  static const Color trackColor = Color.fromRGBO(220, 190, 251, 1.0);
  static const Color dotColor = Colors.white;

  static const List<Color> barColors = [
    Color.fromRGBO(30, 0, 59, 1.0),
    Color.fromRGBO(236, 0, 138, 1.0),
    Color.fromRGBO(98, 133, 218, 1.0),
  ];

  static const double barGradientStartAngle = 0.0;
  static const double barGradientEndAngle = 180.0;
  static const double trackGradientStartAngle = 0.0;
  static const double trackGradientEndAngle = 180.0;
  static const bool dynamicGradient = false;
}

class BarColorHelper {
  static List<Color> createBarColorList(Color barColor) => [barColor, barColor];
}
