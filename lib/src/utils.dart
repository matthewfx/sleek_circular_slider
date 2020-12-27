import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/src/unit_conversions.dart';

bool isPointInsideCircle(Offset point, Offset center, double rradius) {
  var radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}

bool isPointAlongCircle(
  Offset point,
  Offset center,
  double radius,
  double width,
) {
  // distance is root(sqr(x2 - x1) + sqr(y2 - y1))
  // i.e., (7,8) and (3,2) -> 7.21
  var dx = math.pow(point.dx - center.dx, 2);
  var dy = math.pow(point.dy - center.dy, 2);
  var distance = math.sqrt(dx + dy);
  return (distance - radius).abs() < width;
}

double calculateRawAngle(
    {@required double startAngle,
    @required double angleRange,
    @required double selectedAngle,
    bool counterClockwise = false}) {
  double angle = radiansToDegrees(selectedAngle);

  double calcAngle = 0.0;
  if (!counterClockwise) {
    if (angle >= startAngle && angle <= 360.0) {
      calcAngle = angle - startAngle;
    } else {
      calcAngle = 360.0 - startAngle + angle;
    }
  } else {
    if (angle <= startAngle) {
      calcAngle = startAngle - angle;
    } else {
      calcAngle = 360.0 - angle + startAngle;
    }
  }
  return calcAngle;
}

double calculateAngle(
    {@required double startAngle,
    @required double angleRange,
    @required selectedAngle,
    @required defaultAngle,
    bool counterClockwise = false}) {
  if (selectedAngle == null) {
    return defaultAngle;
  }

  double calcAngle = calculateRawAngle(
      startAngle: startAngle,
      angleRange: angleRange,
      selectedAngle: selectedAngle,
      counterClockwise: counterClockwise);

  if (calcAngle - angleRange > (360.0 - angleRange) * 0.5) {
    return 0.0;
  } else if (calcAngle > angleRange) {
    return angleRange;
  }

  return calcAngle;
}

bool isAngleWithinRange(
    {@required double startAngle,
    @required double angleRange,
    @required touchAngle,
    @required previousAngle,
    bool counterClockwise = false}) {
  double calcAngle = calculateRawAngle(
      startAngle: startAngle,
      angleRange: angleRange,
      selectedAngle: touchAngle,
      counterClockwise: counterClockwise);

  if (calcAngle > angleRange) {
    return false;
  }
  return true;
}

int valueToDuration(double value, double previous, double min, double max) {
  final divider = (max - min) / 100;
  return divider != 0 ? (value - previous).abs() ~/ divider * 15 : 0;
}

double valueToPercentage(double value, double min, double max) {
  return value / ((max - min) / 100);
}

double valueToAngle(double value, double min, double max, double angleRange) {
  return percentageToAngle(
      valueToPercentage(value - min, min, max), angleRange);
}

double percentageToValue(double percentage, double min, double max) {
  return ((max - min) / 100) * percentage + min;
}

double percentageToAngle(double percentage, double angleRange) {
  final step = angleRange / 100;
  if (percentage > 100) {
    return angleRange;
  } else if (percentage < 0) {
    return 0.5;
  }
  return percentage * step;
}

double angleToValue(double angle, double min, double max, double angleRange) {
  return percentageToValue(angleToPercentage(angle, angleRange), min, max);
}

double angleToPercentage(double angle, double angleRange) {
  final step = angleRange / 100;
  if (angle > angleRange) {
    return 100;
  } else if (angle < 0.5) {
    return 0;
  }
  return angle / step;
}
