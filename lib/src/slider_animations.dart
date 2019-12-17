import 'package:flutter/material.dart';

typedef void ThreeAnimParams(
    double animation1, double animation2, double animation3);

class SpinAnimationManager {
  final TickerProvider tickerProvider;
  final Duration duration;
  final ThreeAnimParams animate;
  SpinAnimationManager({
    @required this.animate,
    @required this.duration,
    @required this.tickerProvider,
  })  : assert(duration != null),
        assert(tickerProvider != null),
        assert(animate != null);

  Animation<double> animation;
  Animation<double> _animation1;
  Animation<double> _animation2;
  Animation<double> _animation3;
  AnimationController _animController;
  bool _animationCompleted = false;

  void spin() {
    _animController =
        AnimationController(vsync: tickerProvider, duration: duration)
          ..addListener(() {
            animate(_animation1.value, _animation2.value, _animation3.value);
            // setState(() {
            //   _currentAngle = _animation3 != null ? _animation3.value : 0;
            //   _startAngle = _animation2 != null ? math.pi * _animation2.value : 0;
            //   _rotation = _animation1.value;
            //   // _angleRange = 360 - _animation.value;
            //   // update painter and the on change closure
            //   _setupPainter();
            //   _updateOnChange();
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

  // void _animate() {
  //   if (!widget.appearance.animationEnabled || _animController == null) {
  //     // if there is no animation we need to update painter and onChange value
  //     _setupPainter();
  //     _updateOnChange();
  //     return;
  //   }

  //   _animationCompleted = false;

  //   final duration = valueToDuration(widget.initialValue,
  //       _oldWidgetValue ?? widget.min, widget.min, widget.max);

  //   _animController.duration = Duration(milliseconds: duration);

  //   final curvedAnimation = CurvedAnimation(
  //     parent: _animController,
  //     curve: Curves.easeOut,
  //   );

  //   _animation = Tween<double>(begin: _oldWidgetAngle ?? 0, end: widget.angle)
  //       .animate(curvedAnimation)
  //         ..addListener(() {
  //           setState(() {
  //             if (!_animationCompleted) {
  //               _currentAngle = _animation.value;
  //               // update painter and the on change closure
  //               _setupPainter();
  //               _updateOnChange();
  //             }
  //           });
  //         })
  //         ..addStatusListener((status) {
  //           if (status == AnimationStatus.completed) {
  //             _animationCompleted = true;

  //             _animController.reset();
  //           }
  //         });
  //   _animController.forward();
  // }
}

class SpinnerCurve extends Curve {
  const SpinnerCurve();

  @override
  double transform(double t) => (t <= 0.5) ? 2 * t : 2 * (1 - t);
}
