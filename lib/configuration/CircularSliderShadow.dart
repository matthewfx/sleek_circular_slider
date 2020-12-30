import 'package:flutter/material.dart';

class CircularSliderShadow {
  final Color color;
  final double maxOpacity;
  final double step;

  const CircularSliderShadow({
    this.color = DefaultShadow.color,
    this.maxOpacity = DefaultShadow.maxOpacity,
    this.step,
  });
}

class DefaultShadow {
  static const Color color = Color.fromRGBO(44, 87, 192, 1.0);
  static const double maxOpacity = 0.2;
}
