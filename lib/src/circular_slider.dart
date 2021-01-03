library circular_slider;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sleek_circular_slider/src/animations/value_changed_animation_manager.dart';
import 'package:sleek_circular_slider/src/painters/background_painter.dart';
import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';
import 'package:sleek_circular_slider/src/painters/current_value_painter.dart';
import 'package:sleek_circular_slider/src/painters/progress_bar_painter.dart';
import 'package:sleek_circular_slider/src/painters/shadow_painter.dart';
import 'package:sleek_circular_slider/src/animations/spin_animation_manager.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderSettings.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';
import 'package:sleek_circular_slider/src/utilities/utils.dart';
import 'widgets/slider_label.dart';
import 'dart:math' as math;

part 'curve_painter.dart';
part 'widgets/custom_gesture_recognizer.dart';

typedef void OnChange(double value);
typedef Widget InnerWidget(double percentage);

class SliderCallbacks {
  final OnChange onChange;
  final OnChange onChangeStart;
  final OnChange onChangeEnd;

  const SliderCallbacks({
    this.onChange,
    this.onChangeStart,
    this.onChangeEnd,
  });
}

class SliderValues {
  final double initialValue;
  final double minimumValue;
  final double maximumValue;

  const SliderValues({
    this.initialValue = 50,
    this.minimumValue = 0,
    this.maximumValue = 100,
  })  : assert(initialValue != null),
        assert(minimumValue != null),
        assert(maximumValue != null),
        assert(minimumValue <= maximumValue),
        assert(initialValue >= minimumValue && initialValue <= maximumValue);
}

class SleekCircularSlider extends StatefulWidget {
  final CircularSliderSettings settings;
  final SliderCallbacks callbacks;
  final SliderValues values;
  final InnerWidget innerWidget;

  const SleekCircularSlider({
    Key key,
    this.values = const SliderValues(),
    this.callbacks = const SliderCallbacks(),
    this.settings = const CircularSliderSettings(),
    this.innerWidget,
  }) : super(key: key);

  double get initialAngle => valueToAngle(
        values.initialValue,
        values.minimumValue,
        values.maximumValue,
        settings.geometry.angleRange,
      );

  @override
  _SleekCircularSliderState createState() => _SleekCircularSliderState();
}

class _SleekCircularSliderState extends State<SleekCircularSlider>
    with SingleTickerProviderStateMixin {
  bool _isHandlerSelected;
  bool _animationInProgress = false;
  _CurvePainter _painter;
  double _oldWidgetAngle;
  double _oldWidgetValue;
  double _currentAngle;
  double _startAngle;
  double _angleRange;
  double _selectedAngle;
  double _rotation;
  SpinAnimationManager _spinManager;
  ValueChangedAnimationManager _animationManager;

  bool get _interactionEnabled =>
      widget.callbacks.onChangeEnd != null ||
      widget.callbacks.onChange != null &&
          !widget.settings.features.spinnerMode;

  double get currentValue => angleToValue(
        _currentAngle,
        widget.values.minimumValue,
        widget.values.maximumValue,
        _angleRange,
      );

  @override
  void initState() {
    super.initState();
    _startAngle = widget.settings.geometry.startAngle;
    _angleRange = widget.settings.geometry.angleRange;

    if (!widget.settings.features.animationEnabled) {
      return;
    }

    if (widget.settings.features.spinnerMode) {
      _spinManager = SpinAnimationManager(
        tickerProvider: this,
        duration:
            Duration(milliseconds: widget.settings.features.spinnerDuration),
        spinAnimation: ((double anim1, anim2, anim3) {
          setState(() {
            _rotation = anim1 != null ? anim1 : 0;
            _startAngle = anim2 != null ? math.pi * anim2 : 0;
            _currentAngle = anim3 != null ? anim3 : 0;
            _setupPainter();
            _updateOnChange();
          });
        }),
      );

      _spinManager.spin();
    } else if (widget.settings.features.animationEnabled) {
      _animationManager = ValueChangedAnimationManager(
        tickerProvider: this,
        minValue: widget.values.minimumValue,
        maxValue: widget.values.maximumValue,
        durationMultiplier:
            widget.settings.features.animationDurationMultiplier,
      );

      _animate();
    }
  }

  @override
  void didUpdateWidget(SleekCircularSlider oldWidget) {
    if (oldWidget.initialAngle != widget.initialAngle) {
      _animate();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _animate() {
    if (!widget.settings.features.animationEnabled ||
        widget.settings.features.spinnerMode) {
      _setupPainter();
      _updateOnChange();
      return;
    }

    _animationManager.animate(
      initialValue: widget.values.initialValue,
      angle: widget.initialAngle,
      oldAngle: _oldWidgetAngle,
      oldValue: _oldWidgetValue,
      valueChangedAnimation: ((double newValue, bool animationCompleted) {
        _animationInProgress = !animationCompleted;
        setState(() {
          if (!animationCompleted) {
            _currentAngle = newValue;
            // update painter and the on change closure
            _setupPainter();
            _updateOnChange();
          }
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// If painter is null there is a need to setup it to prevent exceptions.
    if (_painter == null) {
      _setupPainter();
    }

    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        _CustomPanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_CustomPanGestureRecognizer>(
          () => _CustomPanGestureRecognizer(
            onPanDown: _onPanDown,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
          ),
          (_CustomPanGestureRecognizer instance) {},
        ),
      },
      child: _rotation != null ? rotatedCustomPaint() : customPaint(),
    );
  }

  @override
  void dispose() {
    if (_spinManager != null) _spinManager.dispose();
    if (_animationManager != null) _animationManager.dispose();
    super.dispose();
  }

  void _setupPainter() {
    var defaultAngle = _currentAngle ?? widget.initialAngle;
    if (_oldWidgetAngle != null) {
      if (_oldWidgetAngle != widget.initialAngle) {
        _selectedAngle = null;
        defaultAngle = widget.initialAngle;
      }
    }

    _currentAngle = calculateAngle(
      _startAngle,
      _angleRange,
      _selectedAngle,
      defaultAngle,
      widget.settings.features.counterClockwise,
    );

    _painter = _CurvePainter(
        startAngle: _startAngle,
        angleRange: _angleRange,
        angle: _currentAngle < 0.5 ? 0.5 : _currentAngle,
        settings: widget.settings);

    _oldWidgetAngle = widget.initialAngle;
    _oldWidgetValue = widget.values.initialValue;
  }

  Widget rotatedCustomPaint() {
    return Transform(
      transform: Matrix4.identity()..rotateZ((_rotation) * 5 * math.pi / 6),
      alignment: FractionalOffset.center,
      child: customPaint(),
    );
  }

  Widget customPaint() {
    return CustomPaint(
      painter: _painter,
      child: Container(
        width: widget.settings.geometry.size,
        height: widget.settings.geometry.size,
        child: widget.settings.features.spinnerMode
            ? null
            : widget.innerWidget != null
                ? widget.innerWidget(currentValue)
                : SliderLabel(
                    value: currentValue,
                    settings: widget.settings,
                  ),
      ),
    );
  }

  void _onPanUpdate(Offset details) {
    if (_painter.center == null || !_isHandlerSelected) return;

    _handlePan(details, false);
  }

  void _updateOnChange() {
    if (_animationInProgress) return;

    widget.callbacks.onChange?.call(currentValue);
  }

  void _onPanEnd(Offset details) {
    _handlePan(details, true);
    widget.callbacks.onChangeEnd?.call(currentValue);

    _isHandlerSelected = false;
  }

  void _handlePan(Offset details, bool isPanEnd) {
    if (_painter.center == null) return;

    final RenderBox renderBox = context.findRenderObject();
    final position = renderBox.globalToLocal(details);
    final touchWidth = widget.settings.geometry.progressBarWidth >= 25.0
        ? widget.settings.geometry.progressBarWidth
        : 25.0;
    if (isPointAlongCircle(
        position, _painter.center, _painter.radius, touchWidth)) {
      _selectedAngle = coordinatesToRadians(_painter.center, position);
      _setupPainter();
      _updateOnChange();
      setState(() {});
    }
  }

  bool _onPanDown(Offset details) {
    if (_painter == null || _interactionEnabled == false) return false;

    final RenderBox renderBox = context.findRenderObject();
    final position = renderBox.globalToLocal(details);

    if (position == null) return false;

    final touchAngle = coordinatesToRadians(_painter.center, position);
    final angleWithinRange = isAngleWithinRange(
      _startAngle,
      _angleRange,
      touchAngle,
      _currentAngle,
      widget.settings.features.counterClockwise,
    );

    if (!angleWithinRange) return false;

    final double touchWidth = widget.settings.geometry.progressBarWidth >= 25.0
        ? widget.settings.geometry.progressBarWidth
        : 25.0;

    final pointAlongCircle = isPointAlongCircle(
        position, _painter.center, _painter.radius, touchWidth);

    if (pointAlongCircle) {
      _isHandlerSelected = true;
      widget.callbacks.onChangeStart?.call(currentValue);
      _onPanUpdate(details);
    } else {
      _isHandlerSelected = false;
    }

    return _isHandlerSelected;
  }
}
