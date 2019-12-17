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
    _animation2 = Tween<double>(begin: -240.0, end: 180.0).animate(
        CurvedAnimation(
            parent: _animController,
            curve: const Interval(0, 1.0, curve: Curves.linear)));
    _animation3 = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 1.0, curve: SpinnerCurve())));
  }
}

class SpinnerCurve extends Curve {
  const SpinnerCurve();

  @override
  double transform(double t) => (t <= 0.5) ? 2 * t : 2 * (1 - t);
}

typedef void ValueChangeAnimation(double animation, bool animationFinished);

class ValueChangedAnimationManager {
  final TickerProvider tickerProvider;
  final double initialValue;
  final double minValue;
  final double maxValue;
  final double angle;

  ValueChangedAnimationManager(
      {@required this.tickerProvider,
      @required this.initialValue,
      @required this.minValue,
      @required this.maxValue,
      @required this.angle});
  Animation<double> _animation;
  bool _animationCompleted = false;
  AnimationController _animController;

  void animate(
      {double oldValue,
      double oldAngle,
      ValueChangeAnimation valueChangedAnimation}) {
    _animationCompleted = false;

    final duration =
        valueToDuration(initialValue, oldValue ?? minValue, minValue, maxValue);

    _animController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: duration));

    final curvedAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _animation =
        Tween<double>(begin: oldAngle ?? 0, end: angle).animate(curvedAnimation)
          ..addListener(() {
            valueChangedAnimation(_animation.value, _animationCompleted);
            // setState(() {
            //   if (!_animationCompleted) {
            //     _currentAngle = _animation.value;
            //     // update painter and the on change closure
            //     _setupPainter();
            //     _updateOnChange();
            //   }
            // });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationCompleted = true;

              _animController.reset();
              _animController.dispose();
            }
          });
    _animController.forward();
  }
}
