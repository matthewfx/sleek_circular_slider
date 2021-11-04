library circular_slider;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sleek_circular_slider/src/animations/value_changed_animation_manager.dart';
import 'package:sleek_circular_slider/src/animations/spin_animation_manager.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_callbacks.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_painters.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_settings.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_values.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';
import 'package:sleek_circular_slider/src/utilities/utils.dart';
import 'widgets/slider_label.dart';
import 'dart:math' as math;

part 'curve_painter.dart';
part 'widgets/custom_gesture_recognizer.dart';

typedef Widget InnerWidget(double percentage);

class SleekCircularSlider extends StatefulWidget {
  final CircularSliderValues values;
  final CircularSliderSettings settings;
  final CircularSliderCallbacks callbacks;
  final CircularSliderPainters painters;
  final InnerWidget innerWidget;

  SleekCircularSlider({
    Key key,
    this.values = const CircularSliderValues(),
    this.callbacks = const CircularSliderCallbacks(),
    this.settings = const CircularSliderSettings(),
    this.painters,
    this.innerWidget,
  }) : super(key: key);

  double get initialAngle => valueToAngle(
        values.initialValue,
        values.minimumValue,
        values.maximumValue,
        values.angleRange,
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
  double _selectedAngleInRadians;
  double _rotation;
  SpinAnimationManager _spinManager;
  ValueChangedAnimationManager _animationManager;
  CircularSliderPainters _sliderPainters;
  CircularSliderValues _currentValues;

  bool get _interactionEnabled =>
      widget.callbacks.onChangeEnd != null ||
      widget.callbacks.onChange != null &&
          !widget.settings.features.spinnerMode;

  double get currentValue => angleToValue(
        _currentAngle,
        _currentValues.minimumValue,
        _currentValues.maximumValue,
        _currentValues.angleRange,
      );

  @override
  void initState() {
    super.initState();
    _currentValues = widget.values;
    _currentAngle = widget.initialAngle;
    _sliderPainters = this.widget.painters ?? CircularSliderPainters();

    if (widget.settings.features.spinnerMode) {
      _spinManager = SpinAnimationManager(
        tickerProvider: this,
        duration:
            Duration(milliseconds: widget.settings.features.spinnerDuration),
        spinAnimation: ((double anim1, anim2, anim3) {
          setState(() {
            _rotation = anim1 != null ? anim1 : 0;

            _currentValues = CircularSliderValues(
              currentAngle: _currentValues.currentAngle,
              initialValue: _currentValues.initialValue,
              minimumValue: _currentValues.minimumValue,
              maximumValue: _currentValues.maximumValue,
              progressBarWidth: _currentValues.progressBarWidth,
              trackWidth: _currentValues.trackWidth,
              startAngle: anim2 != null ? math.pi * anim2 : 0,
              angleRange: _currentValues.angleRange,
              handlerSize: _currentValues.handlerSize,
              size: _currentValues.size,
            );
            _currentAngle = anim3 != null ? anim3 : 0;
            updateAngles();
            recreatePainter();
            handleOnChange();
          });
        }),
      );

      _spinManager.spin();
    } else if (widget.settings.features.animationEnabled) {
      _animationManager = ValueChangedAnimationManager(
        tickerProvider: this,
        minValue: _currentValues.minimumValue,
        maxValue: _currentValues.maximumValue,
        durationMultiplier:
            widget.settings.features.animationDurationMultiplier,
      );
    }
    updateSliderUi();
  }

  @override
  void didUpdateWidget(SleekCircularSlider oldWidget) {
    if (oldWidget.initialAngle != widget.initialAngle) {
      updateSliderUi();
    }
    super.didUpdateWidget(oldWidget);
  }

  void updateSliderUi() {
    if (!widget.settings.features.animationEnabled ||
        widget.settings.features.spinnerMode) {
      updateAngles();
      recreatePainter();
      handleOnChange();
      return;
    }

    _animationManager.animate(
      initialValue: _currentValues.initialValue,
      angle: widget.initialAngle,
      oldAngle: _oldWidgetAngle,
      oldValue: _oldWidgetValue,
      valueChangedAnimation: ((double newValue, bool animationCompleted) {
        _animationInProgress = !animationCompleted;
        setState(() {
          if (!animationCompleted) {
            _currentAngle = newValue;
            // update painter and the on change closure
            updateAngles();
            recreatePainter();
            handleOnChange();
          }
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
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

  void updateAngles() {
    if (_oldWidgetAngle != null && _oldWidgetAngle != widget.initialAngle) {
      _selectedAngleInRadians = null;
      _currentAngle = widget.initialAngle;
    }
    if (_selectedAngleInRadians == null) {
      _currentAngle = _currentAngle ?? widget.initialAngle;
    } else {
      _currentAngle = calculateAngle(
        _currentValues.startAngle,
        _currentValues.angleRange,
        _selectedAngleInRadians,
        widget.settings.features.counterClockwise,
      );
    }

    _currentValues = CircularSliderValues(
      initialValue: _currentValues.initialValue,
      minimumValue: _currentValues.minimumValue,
      maximumValue: _currentValues.maximumValue,
      progressBarWidth: _currentValues.progressBarWidth,
      trackWidth: _currentValues.trackWidth,
      startAngle: _currentValues.startAngle,
      currentAngle: _currentAngle,
      angleRange: _currentValues.angleRange,
      handlerSize: _currentValues.handlerSize,
      size: _currentValues.size,
    );

    _oldWidgetAngle = widget.initialAngle;
    _oldWidgetValue = _currentValues.initialValue;
  }

  void recreatePainter() {
    final backgroundPainter = _sliderPainters.backgroundPainter(
      widget.settings,
      _currentValues,
    );

    final shadowPainter = _sliderPainters.shadowPainter(
      widget.settings,
      _currentValues,
    );

    final progressBarPainter = _sliderPainters.progressBarPainter(
      widget.settings,
      _currentValues,
    );

    final currentValuePainter = _sliderPainters.currentValuePainter(
      widget.settings,
      _currentValues,
    );

    _painter = _CurvePainter(
      backgroundPainter: backgroundPainter,
      shadowPainter: shadowPainter,
      progressBarPainter: progressBarPainter,
      currentValuePainter: currentValuePainter,
      settings: widget.settings,
      values: _currentValues,
    );
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
        width: _currentValues.size,
        height: _currentValues.size,
        child: widget.settings.features.spinnerMode
            ? null
            : widget.innerWidget != null
                ? widget.innerWidget(currentValue)
                : SliderLabel(
                    value: currentValue,
                    settings: widget.settings,
                    values: _currentValues,
                  ),
      ),
    );
  }

  void _onPanUpdate(Offset details) {
    if (_painter.values.center == null || !_isHandlerSelected) return;

    _handlePan(details);
  }

  void handleOnChange() {
    if (_animationInProgress) return;

    widget.callbacks.onChange?.call(currentValue);
  }

  void _onPanEnd(Offset details) {
    _handlePan(details);
    widget.callbacks.onChangeEnd?.call(currentValue);

    _isHandlerSelected = false;
  }

  void _handlePan(Offset details) {
    if (_painter.values.center == null) return;

    final RenderBox renderBox = context.findRenderObject();
    final position = renderBox.globalToLocal(details);
    final touchWidth = _currentValues.progressBarWidth >= 25.0
        ? _currentValues.progressBarWidth
        : 25.0;
    if (isPointAlongCircle(
        position, _painter.values.center, _painter.values.radius, touchWidth)) {
      _selectedAngleInRadians =
          coordinatesToRadians(_painter.values.center, position);
      updateAngles();
      recreatePainter();
      handleOnChange();
      setState(() {});
    }
  }

  bool _onPanDown(Offset details) {
    if (_painter == null || _interactionEnabled == false) return false;

    final RenderBox renderBox = context.findRenderObject();
    final position = renderBox.globalToLocal(details);

    if (position == null) return false;

    final touchAngle = coordinatesToRadians(_painter.values.center, position);
    final angleWithinRange = isAngleWithinRange(
      _currentValues.startAngle,
      _currentValues.angleRange,
      touchAngle,
      _currentAngle,
      widget.settings.features.counterClockwise,
    );

    if (!angleWithinRange) return false;

    final double touchWidth = _currentValues.progressBarWidth >= 25.0
        ? _currentValues.progressBarWidth
        : 25.0;

    final pointAlongCircle = isPointAlongCircle(
        position, _painter.values.center, _painter.values.radius, touchWidth);

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
