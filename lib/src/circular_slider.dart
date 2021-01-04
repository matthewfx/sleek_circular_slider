library circular_slider;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sleek_circular_slider/src/animations/value_changed_animation_manager.dart';
import 'package:sleek_circular_slider/src/circular_slider_parameters.dart';
import 'package:sleek_circular_slider/src/painters/circular_arc_painter.dart';
import 'package:sleek_circular_slider/src/animations/spin_animation_manager.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderSettings.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderValues.dart';
import 'package:sleek_circular_slider/src/utilities/unit_conversions.dart';
import 'package:sleek_circular_slider/src/utilities/utils.dart';
import 'widgets/slider_label.dart';
import 'dart:math' as math;

part 'curve_painter.dart';
part 'widgets/custom_gesture_recognizer.dart';

class SleekCircularSlider extends StatefulWidget {
  final CircularSliderValues values;
  final CircularSliderSettings settings;
  final SliderCallbacks callbacks;
  final SliderPainters painters;
  final InnerWidget innerWidget;

  SleekCircularSlider({
    Key key,
    this.values = const CircularSliderValues(),
    this.callbacks = const SliderCallbacks(),
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
  double _startAngleInDegrees;
  double _angleRangeInDegrees;
  double _selectedAngleInRadians;
  double _rotation;
  SpinAnimationManager _spinManager;
  ValueChangedAnimationManager _animationManager;
  SliderPainters _sliderPainters;

  bool get _interactionEnabled =>
      widget.callbacks.onChangeEnd != null ||
      widget.callbacks.onChange != null &&
          !widget.settings.features.spinnerMode;

  double get currentValue => angleToValue(
        _currentAngle,
        widget.values.minimumValue,
        widget.values.maximumValue,
        _angleRangeInDegrees,
      );

  @override
  void initState() {
    super.initState();
    _sliderPainters = this.widget.painters ?? SliderPainters();

    _startAngleInDegrees = widget.values.startAngle;
    _angleRangeInDegrees = widget.values.angleRange;

    updateAngles();

    recreatePainter();

    if (widget.settings.features.spinnerMode) {
      _spinManager = SpinAnimationManager(
        tickerProvider: this,
        duration:
            Duration(milliseconds: widget.settings.features.spinnerDuration),
        spinAnimation: ((double anim1, anim2, anim3) {
          setState(() {
            _rotation = anim1 != null ? anim1 : 0;
            _startAngleInDegrees = anim2 != null ? math.pi * anim2 : 0;
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
        minValue: widget.values.minimumValue,
        maxValue: widget.values.maximumValue,
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
    var defaultAngle = _currentAngle ?? widget.initialAngle;
    if (_oldWidgetAngle != null && _oldWidgetAngle != widget.initialAngle) {
      _selectedAngleInRadians = null;
      defaultAngle = widget.initialAngle;
    }

    _currentAngle = calculateAngle(
      _startAngleInDegrees,
      _angleRangeInDegrees,
      _selectedAngleInRadians,
      defaultAngle,
      widget.settings.features.counterClockwise,
    );

    _oldWidgetAngle = widget.initialAngle;
    _oldWidgetValue = widget.values.initialValue;
  }

  void recreatePainter() {
    final angle = _currentAngle < 0.5 ? 0.5 : _currentAngle;

    final circularArcPainter = CircularArcPainter(
      widget.settings,
      widget.values,
      angle,
    );

    final updatedValues = CircularSliderValues(
      initialValue: widget.values.initialValue,
      minimumValue: widget.values.minimumValue,
      maximumValue: widget.values.maximumValue,
      progressBarWidth: widget.values.progressBarWidth,
      trackWidth: widget.values.trackWidth,
      startAngle: _startAngleInDegrees,
      angleRange: _angleRangeInDegrees,
      handlerSize: widget.values.handlerSize,
      size: widget.values.size,
    );

    final backgroundPainter = _sliderPainters.backgroundPainter(
      widget.settings,
      updatedValues,
      circularArcPainter,
      angle,
    );

    final shadowPainter = _sliderPainters.shadowPainter(
      widget.settings,
      updatedValues,
      circularArcPainter,
      angle,
    );

    final progressBarPainter = _sliderPainters.progressBarPainter(
      widget.settings,
      updatedValues,
      circularArcPainter,
      angle,
    );

    final currentValuePainter = _sliderPainters.currentValuePainter(
      widget.settings,
      updatedValues,
      circularArcPainter,
      angle,
    );

    _painter = _CurvePainter(
      circularArcPainter: circularArcPainter,
      backgroundPainter: backgroundPainter,
      shadowPainter: shadowPainter,
      progressBarPainter: progressBarPainter,
      currentValuePainter: currentValuePainter,
      settings: widget.settings,
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
        width: widget.values.size,
        height: widget.values.size,
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
    final touchWidth = widget.values.progressBarWidth >= 25.0
        ? widget.values.progressBarWidth
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
      _startAngleInDegrees,
      _angleRangeInDegrees,
      touchAngle,
      _currentAngle,
      widget.settings.features.counterClockwise,
    );

    if (!angleWithinRange) return false;

    final double touchWidth = widget.values.progressBarWidth >= 25.0
        ? widget.values.progressBarWidth
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
