import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Converts degrees to radians.
///
/// Takes [degree] value and returns its equivalent in radians.
double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}

/// Converts radians to degrees.
///
/// Takes [radians] value and returns its equivalent in degrees.
double radiansToDegrees(double radians) {
  return radians * (180 / math.pi);
}

/// Converts degrees to x,y coordinates on a circle.
///
/// Takes a [center] point, [degrees] angle, and [radius] to calculate
/// the position on the circle's circumference.
/// Returns an Offset representing the x,y coordinates.
Offset degreesToCoordinates(Offset center, double degrees, double radius) {
  return radiansToCoordinates(center, degreeToRadians(degrees), radius);
}

/// Converts radians to x,y coordinates on a circle.
///
/// Takes a [center] point, [radians] angle, and [radius] to calculate
/// the position on the circle's circumference.
/// Returns an Offset representing the x,y coordinates.
Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * math.cos(radians);
  var dy = center.dy + radius * math.sin(radians);
  return Offset(dx, dy);
}

/// Converts x,y coordinates to radians angle relative to a circle's center.
///
/// Takes a [center] point and [coords] position to calculate the angle in radians.
/// Returns the normalized angle in radians.
double coordinatesToRadians(Offset center, Offset coords) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return radiansNormalized(math.atan2(b, a));
}

/// Normalizes a radian value to ensure consistent angle representation.
///
/// Takes [radians] and normalizes it to the appropriate range.
/// Returns the normalized angle in radians.
double radiansNormalized(double radians) {
  var normalized = radians < 0 ? -radians : 2 * math.pi - radians;
  return normalized;
}

/// Checks if a point is inside a circle.
///
/// Takes a [point], [center] of the circle, and [rradius] (radius).
/// Returns true if the point is inside the circle, false otherwise.
bool isPointInsideCircle(Offset point, Offset center, double rradius) {
  var radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}

/// Checks if a point is along the circumference of a circle.
///
/// Takes a [point], [center] of the circle, [radius], and [width].
/// Returns true if the point is along the circle's circumference, false otherwise.
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

/// Calculates the raw angle for a given selection.
///
/// Takes [startAngle], [angleRange], [selectedAngle], and an optional
/// [counterClockwise] boolean. Returns the calculated angle.
double calculateRawAngle({
  required double startAngle,
  required double angleRange,
  required double selectedAngle,
  bool counterClockwise = false,
}) {
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

/// Calculates the angle for a given selection within a range.
///
/// Takes [startAngle], [angleRange], [selectedAngle], [defaultAngle],
/// and an optional [counterClockwise] boolean. Returns the calculated angle
/// or the default angle if selectedAngle is null.
double calculateAngle({
  required double startAngle,
  required double angleRange,
  required selectedAngle,
  required defaultAngle,
  bool counterClockwise = false,
}) {
  if (selectedAngle == null) {
    return defaultAngle;
  }

  double calcAngle = calculateRawAngle(
    startAngle: startAngle,
    angleRange: angleRange,
    selectedAngle: selectedAngle,
    counterClockwise: counterClockwise,
  );

  if (calcAngle - angleRange > (360.0 - angleRange) * 0.5) {
    return 0.0;
  } else if (calcAngle > angleRange) {
    return angleRange;
  }

  return calcAngle;
}

/// Checks if a touch angle is within a specified range.
///
/// Takes [startAngle], [angleRange], [touchAngle], [previousAngle],
/// and an optional [counterClockwise] boolean. Returns true if the angle
/// is within the range, false otherwise.
bool isAngleWithinRange({
  required double startAngle,
  required double angleRange,
  required touchAngle,
  required previousAngle,
  bool counterClockwise = false,
}) {
  double calcAngle = calculateRawAngle(
    startAngle: startAngle,
    angleRange: angleRange,
    selectedAngle: touchAngle,
    counterClockwise: counterClockwise,
  );

  return calcAngle <= angleRange;
}

/// Converts a value to a duration in milliseconds.
///
/// Takes a [value], [previous] value, [min], and [max] range.
/// Returns the duration in milliseconds corresponding to the value change.
int valueToDuration(double value, double previous, double min, double max) {
  final divider = (max - min) / 100;
  return divider != 0 ? (value - previous).abs() ~/ divider * 15 : 0;
}

/// Converts a value to its percentage representation within a given range.
///
/// Takes [value] and converts it to a percentage based on the [min] and [max] range.
/// Returns the percentage (0-100) that the value represents in the range
double valueToPercentage(double value, double min, double max) {
  if (max <= min) return 0;
  return ((value - min) / (max - min)) * 100;
}

/// Converts a value to the corresponding angle based on the slider's range.
///
/// Takes [value] and converts it to an angle using [min], [max], and [angleRange].
/// Returns the angle corresponding to the value within the total available angle range.
double valueToAngle(double value, double min, double max, double angleRange) {
  return percentageToAngle(valueToPercentage(value, min, max), angleRange);
}

/// Converts a percentage to its corresponding value within a given range.
///
/// Takes [percentage] and converts it to a value based on the [min] and [max] range.
/// Returns the value within the range corresponding to the percentage.
double percentageToValue(double percentage, double min, double max) {
  return min + (percentage / 100) * (max - min);
}

/// Converts a percentage to its corresponding angle within the slider's range.
///
/// Takes [percentage] and converts it to an angle based on the [angleRange].
/// Returns the angle corresponding to the percentage, with constraints applied.
/// Returns [angleRange] if percentage exceeds 100, and 0.5 if percentage is negative.
double percentageToAngle(double percentage, double angleRange) {
  if (percentage > 100) {
    return angleRange;
  } else if (percentage < 0) {
    return 0.5;
  }
  return (percentage / 100) * angleRange;
}

/// Converts an angle to its corresponding value within a given range.
///
/// Takes [angle] and converts it to a value using [min], [max], and [angleRange].
/// Returns the value within the range corresponding to the angle.
double angleToValue(double angle, double min, double max, double angleRange) {
  return percentageToValue(angleToPercentage(angle, angleRange), min, max);
}

/// Converts an angle to its corresponding percentage representation.
///
/// Takes [angle] and [angleRange] as parameters and returns the percentage (0-100)
/// that the angle represents in the total available angle range.
///
/// Returns 0 if [angleRange] is non-positive, 100 if [angle] exceeds [angleRange],
/// and 0 if [angle] is less than or equal to 0.5.
double angleToPercentage(double angle, double angleRange) {
  if (angleRange <= 0) return 0;
  if (angle > angleRange) {
    return 100;
  } else if (angle <= 0.5) {
    return 0;
  }
  return (angle / angleRange) * 100;
}
