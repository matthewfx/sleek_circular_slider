import 'package:flutter/material.dart';

class SpinnerCurve extends Curve {
  const SpinnerCurve();

  @override
  double transform(double tr) => (tr <= 0.5) ? 1.9 * tr : 1.85 * (1 - tr);
}
