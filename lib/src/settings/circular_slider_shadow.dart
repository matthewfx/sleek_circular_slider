import 'package:flutter/material.dart';

class CircularSliderShadow {
  final bool hideShadow;
  final double? _shadowWidth;
  double getShadowWidth(double progressBarWidth) =>
      _shadowWidth ?? DefaultShadow.shadowWidth(progressBarWidth);

  final Color color;
  final double maxOpacity;
  final double? step;

  const CircularSliderShadow({
    this.hideShadow = DefaultShadow.hideShadow,
    double? shadowWidth,
    this.color = DefaultShadow.color,
    this.maxOpacity = DefaultShadow.maxOpacity,
    this.step,
  }) : _shadowWidth = shadowWidth;
}

class DefaultShadow {
  static const bool hideShadow = false;
  static const Color color = Color.fromRGBO(44, 87, 192, 1.0);
  static const double maxOpacity = 0.2;

  static double shadowWidth(double progressBarWidth) => progressBarWidth * 1.4;
}
