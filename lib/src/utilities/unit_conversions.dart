import 'dart:math';

import 'package:flutter/material.dart';

double degreeToRadians(double degree) => (pi / 180) * degree;

double radiansToDegrees(double radians) => radians * (180 / pi);

Offset degreesToCoordinates(
  Offset center,
  double degrees,
  double radius,
) {
  final radians = degreeToRadians(degrees);
  return radiansToCoordinates(center, radians, radius);
}

Offset radiansToCoordinates(
  Offset center,
  double radians,
  double radius,
) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}

double coordinatesToRadians(
  Offset center,
  Offset coords,
) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return _radiansNormalized(atan2(b, a));
}

int valueToDuration(
  double value,
  double previous,
  double min,
  double max,
) {
  final divider = (max - min) / 100;
  return divider != 0 ? (value - previous).abs() ~/ divider * 15 : 0;
}

double valueToAngle(
  double value,
  double min,
  double max,
  double angleRange,
) {
  final percentage = _valueToPercentage(value - min, min, max);
  return _percentageToAngle(percentage, angleRange);
}

double angleToValue(
  double angle,
  double min,
  double max,
  double angleRange,
) {
  final percentage = _angleToPercentage(angle, angleRange);
  return _percentageToValue(percentage, min, max);
}

double _valueToPercentage(
  double value,
  double min,
  double max,
) {
  return value / ((max - min) / 100);
}

double _percentageToValue(
  double percentage,
  double min,
  double max,
) {
  return ((max - min) / 100) * percentage + min;
}

double _percentageToAngle(
  double percentage,
  double angleRange,
) {
  final step = angleRange / 100;
  if (percentage > 100) {
    return angleRange;
  } else if (percentage < 0) {
    return 0.5;
  }
  return percentage * step;
}

double _angleToPercentage(
  double angle,
  double angleRange,
) {
  final step = angleRange / 100;
  if (angle > angleRange) {
    return 100;
  } else if (angle < 0.5) {
    return 0;
  }
  return angle / step;
}

double _radiansNormalized(double radians) {
  var normalized = radians < 0 ? -radians : 2 * pi - radians;
  return normalized;
}
