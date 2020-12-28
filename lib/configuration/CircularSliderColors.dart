import 'package:flutter/material.dart';

class CircularSliderColors {
  final Color trackColor;
  final List<Color> trackColors;
  final Color dotColor;
  final Color shadowColor;
  final List<Color> barColors;

  const CircularSliderColors({
    this.trackColor = CircularSliderDefaultColors.trackColor,
    this.trackColors,
    this.dotColor = CircularSliderDefaultColors.dotColor,
    this.shadowColor = CircularSliderDefaultColors.shadowColor,
    this.barColors = CircularSliderDefaultColors.barColors,
  });
}

class CircularSliderDefaultColors {
  static const Color trackColor = Color.fromRGBO(220, 190, 251, 1.0);
  static const Color dotColor = Colors.white;
  static const Color shadowColor = Color.fromRGBO(44, 87, 192, 1.0);

  static const List<Color> barColors = [
    Color.fromRGBO(30, 0, 59, 1.0),
    Color.fromRGBO(236, 0, 138, 1.0),
    Color.fromRGBO(98, 133, 218, 1.0),
  ];
}

class BarColorHelper {
  static List<Color> createBarColorList(Color barColor) => [barColor, barColor];
}
