import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/src/animations/spinner_curve.dart';

typedef void SpinAnimation(
  double animation1,
  double animation2,
  double animation3,
);

class SpinAnimationManager {
  final TickerProvider tickerProvider;
  final Duration duration;
  final SpinAnimation spinAnimation;

  SpinAnimationManager({
    required this.spinAnimation,
    required this.duration,
    required this.tickerProvider,
  });

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late AnimationController _animController;

  void spin() {
    _animController =
        AnimationController(vsync: tickerProvider, duration: duration)
          ..addListener(() => spinAnimation(
                _animation1.value,
                _animation2.value,
                _animation3.value,
              ))
          ..repeat();

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 1.0, curve: Curves.linear),
      ),
    );
    _animation2 = Tween<double>(begin: -80.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0, 1.0, curve: Curves.linear),
      ),
    );
    _animation3 = Tween(begin: 0.0, end: 360.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 1.0, curve: SpinnerCurve()),
      ),
    );
  }

  void dispose() {
    _animController.dispose();
  }
}
