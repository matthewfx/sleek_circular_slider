import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';

bool isPointInsideCircle(
  Offset point,
  Offset center,
  double rradius,
) {
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
  double startAngle,
  double angleRange,
  double selectedAngle,
  bool counterClockwise,
) {
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
  double startAngle,
  double angleRange,
  double selectedAngle,
  bool counterClockwise,
) {
  double calcAngle = calculateRawAngle(
    startAngle,
    angleRange,
    selectedAngle,
    counterClockwise,
  );

  if (calcAngle - angleRange > (360.0 - angleRange) * 0.5) {
    return 0.0;
  } else if (calcAngle > angleRange) {
    return angleRange;
  }

  return calcAngle < 0.5 ? 0.5 : calcAngle;
}

bool isAngleWithinRange(
  double startAngle,
  double angleRange,
  double selectedAngle,
  previousAngle,
  counterClockwise,
) {
  double calcAngle = calculateRawAngle(
    startAngle,
    angleRange,
    selectedAngle,
    counterClockwise,
  );

  if (calcAngle > angleRange) {
    return false;
  }
  return true;
}
