import 'dart:math' as math;
import 'package:flutter/material.dart';

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}

double radiansToDegrees(double radians) {
  return radians * (180 / math.pi);
}

Offset degreesToCoordinates(Offset center, double degrees, double radius) {
  return radiansToCoordinates(center, degreeToRadians(degrees), radius);
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * math.cos(radians);
  var dy = center.dy + radius * math.sin(radians);
  return Offset(dx, dy);
}

double coordinatesToRadians(Offset center, Offset coords) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return radiansNormalized(math.atan2(b, a));
}

double radiansNormalized(double radians) {
  var normalized = radians < 0 ? -radians : 2 * math.pi - radians;
  return normalized;
}

bool isPointInsideCircle(Offset point, Offset center, double rradius) {
  var radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}

bool isPointAlongCircle(
    Offset point, Offset center, double radius, double width) {
  // distance is root(sqr(x2 - x1) + sqr(y2 - y1))
  // i.e., (7,8) and (3,2) -> 7.21
  var dx = math.pow(point.dx - center.dx, 2);
  var dy = math.pow(point.dy - center.dy, 2);
  var distance = math.sqrt(dx + dy);
  return (distance - radius).abs() < width;
}

double calculateAngle(
    {@required double startAngle,
    @required double angleRange,
    @required selectedAngle,
    @required previousAngle,
    @required defaultAngle,
    bool counterClockwise = false}) {
  if (selectedAngle == null) {
    return defaultAngle;
  }

  if (counterClockwise) {
    return calculateAngleCounterClockwise(
        startAngle: startAngle,
        angleRange: angleRange,
        selectedAngle: selectedAngle,
        previousAngle: previousAngle);
  }

  double angle = radiansToDegrees(selectedAngle);

  if (angle >= startAngle && angle <= angleRange + startAngle) {
    return angle - startAngle;
  } else if (angle <= (startAngle + angleRange) - 360.0) {
    return 360.0 - startAngle + angle;
  } else if (angle > (startAngle + angleRange) - 360.0) {
    return previousAngle >= angleRange / 2.0 ? angleRange : 0.0;
  }
  return previousAngle;
}

double calculateAngleCounterClockwise(
    {@required double startAngle,
    @required double angleRange,
    @required selectedAngle,
    @required previousAngle}) {
  double angle = radiansToDegrees(selectedAngle);

  if (angle < startAngle && startAngle - angle < angleRange) {
    return startAngle - angle;
  } else if (angle < startAngle && startAngle - angle >= angleRange) {
    return angleRange;
  } else if (360.0 - angle <= angleRange - startAngle) {
    return startAngle + 360.0 - angle;
  } else if (360.0 - angle > angleRange - startAngle) {
    return previousAngle >= angleRange / 2.0 ? angleRange : 0.0;
  }
  return previousAngle;
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
