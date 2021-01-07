import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';

typedef void ValueChangeAnimation(double animation, bool animationFinished);

class ValueChangedAnimationManager {
  final TickerProvider tickerProvider;
  final double durationMultiplier;
  final double minValue;
  final double maxValue;

  ValueChangedAnimationManager({
    @required this.tickerProvider,
    @required this.minValue,
    @required this.maxValue,
    this.durationMultiplier = 1.0,
  }) : _animationController = AnimationController(vsync: tickerProvider);

  Animation<double> _animation;
  bool _animationCompleted = false;
  AnimationController _animationController;

  void animate({
    double initialValue,
    double oldValue,
    double angle,
    double oldAngle,
    ValueChangeAnimation valueChangedAnimation,
  }) {
    _animationCompleted = false;

    final _duration = valueToDuration(
      initialValue,
      oldValue ?? minValue,
      minValue,
      maxValue,
    );

    final multipliedDuration = (durationMultiplier * _duration).toInt();
    _animationController.duration = Duration(milliseconds: multipliedDuration);

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
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

              _animationController.reset();
            }
          });
    _animationController.forward();
  }

  void dispose() {
    _animationController.dispose();
  }
}
