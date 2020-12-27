import 'dart:math';

import 'package:flutter/material.dart';

double degreeToRadians(double degree) => (pi / 180) * degree;

double radiansToDegrees(double radians) => radians * (180 / pi);

Offset degreesToCoordinates(Offset center, double degrees, double radius) {
  final radians = degreeToRadians(degrees);
  return radiansToCoordinates(center, radians, radius);
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}

double coordinatesToRadians(Offset center, Offset coords) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return radiansNormalized(atan2(b, a));
}

double radiansNormalized(double radians) {
  var normalized = radians < 0 ? -radians : 2 * pi - radians;
  return normalized;
}
