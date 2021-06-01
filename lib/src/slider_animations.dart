import 'package:flutter/material.dart';
import 'utils.dart';

typedef void SpinAnimation(
    double animation1, double animation2, double animation3);

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
    _animController = AnimationController(
        vsync: tickerProvider, duration: duration)
      ..addListener(() {
        spinAnimation(_animation1.value, _animation2.value, _animation3.value);
      })
      ..repeat();
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 1.0, curve: Curves.linear)));
    _animation2 = Tween<double>(begin: -80.0, end: 100.0).animate(
        CurvedAnimation(
            parent: _animController,
            curve: const Interval(0, 1.0, curve: Curves.linear)));
    _animation3 = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 1.0, curve: SpinnerCurve())));
  }

  void dispose() {
    _animController.dispose();
  }
}

class SpinnerCurve extends Curve {
  const SpinnerCurve();

  @override
  double transform(double tr) => (tr <= 0.5) ? 1.9 * tr : 1.85 * (1 - tr);
}

typedef void ValueChangeAnimation(double animation, bool animationFinished);

class ValueChangedAnimationManager {
  final TickerProvider tickerProvider;
  final double durationMultiplier;
  final double minValue;
  final double maxValue;

  ValueChangedAnimationManager({
    required this.tickerProvider,
    required this.minValue,
    required this.maxValue,
    this.durationMultiplier = 1.0,
  });

  late Animation<double> _animation;
  late AnimationController _animController = AnimationController(vsync: tickerProvider);
  bool _animationCompleted = false;


  void animate(
      {required double initialValue,
      double? oldValue,
      required double angle,
      double? oldAngle,
      required ValueChangeAnimation valueChangedAnimation}) {
    _animationCompleted = false;

    final duration = (durationMultiplier *
            valueToDuration(
                initialValue, oldValue ?? minValue, minValue, maxValue))
        .toInt();

    _animController.duration = Duration(milliseconds: duration);

    final curvedAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _animation =
        Tween<double>(begin: oldAngle ?? 0, end: angle).animate(curvedAnimation)
          ..addListener(() {
            valueChangedAnimation(_animation.value, _animationCompleted);
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationCompleted = true;

              _animController.reset();
            }
          });
    _animController.forward();
  }

  void dispose() {
    _animController.dispose();
  }
}
