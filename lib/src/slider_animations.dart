import 'package:flutter/material.dart';
import 'utils.dart';

typedef void SpinAnimation(
    double animation1, double animation2, double animation3);

class SpinAnimationManager {
  final TickerProvider tickerProvider;
  final Duration duration;
  final SpinAnimation spinAnimation;
  SpinAnimationManager({
    @required this.spinAnimation,
    @required this.duration,
    @required this.tickerProvider,
  })  : assert(duration != null),
        assert(tickerProvider != null),
        assert(spinAnimation != null);

  Animation<double> _animation1;
  Animation<double> _animation2;
  Animation<double> _animation3;
  AnimationController _animController;

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
  final double minValue;
  final double maxValue;

  ValueChangedAnimationManager({
    @required this.tickerProvider,
    @required this.minValue,
    @required this.maxValue,
  });

  Animation<double> _animation;
  bool _animationCompleted = false;
  AnimationController _animController;

  void animate(
      {double initialValue,
      double oldValue,
      double angle,
      double oldAngle,
      ValueChangeAnimation valueChangedAnimation}) {
    _animationCompleted = false;

    final duration =
        valueToDuration(initialValue, oldValue ?? minValue, minValue, maxValue);
    if (_animController == null) {
      _animController = AnimationController(vsync: tickerProvider);
    }

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
