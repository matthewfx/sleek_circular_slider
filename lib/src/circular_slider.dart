library circular_slider;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'utils.dart';
import 'appearance.dart';
import 'dart:math' as math;

part 'curve_painter.dart';
part 'custom_gesture_recognizer.dart';

typedef void OnChange(double value);
typedef Widget InnerWidget(double percentage);

class SleekCircularSlider extends StatefulWidget {
  final double initialValue;
  final double min;
  final double max;
  final CircularSliderAppearance appearance;
  final OnChange onChange;
  final OnChange onChangeStart;
  final OnChange onChangeEnd;
  final InnerWidget innerWidget;

  double get angle {
    return valueToAngle(initialValue, min, max, appearance.angleRange);
  }

  const SleekCircularSlider(
      {Key key,
      this.initialValue = 50,
      this.min = 0,
      this.max = 100,
      this.appearance,
      this.onChange,
      this.onChangeStart,
      this.onChangeEnd,
      this.innerWidget})
      : assert(initialValue != null),
        assert(min != null),
        assert(max != null),
        assert(min <= max),
        assert(initialValue >= min && initialValue <= max),
        super(key: key);
  @override
  _SleekCircularSliderState createState() => _SleekCircularSliderState();
}

class _SleekCircularSliderState extends State<SleekCircularSlider>
    with SingleTickerProviderStateMixin {
  bool _isHandlerSelected;
  _CurvePainter _painter;
  double _oldWidgetAngle;
  double _oldWidgetValue;
  double _currentAngle;
  double _selectedAngle;
  bool _animationCompleted = false;

  bool get _interactionEnabled =>
      (widget.onChangeEnd != null || widget.onChange != null);
  Animation<double> _animation;
  AnimationController _animController;

  @override
  void initState() {
    super.initState();
    if (!widget.appearance.animationEnabled) {
      return;
    }
    _animController = AnimationController(vsync: this);
    _animate();
  }

  @override
  void didUpdateWidget(SleekCircularSlider oldWidget) {
    if (oldWidget.angle != widget.angle) {
      _animate();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _animate() {
    if (!widget.appearance.animationEnabled || _animController == null) {
      // if there is no animation we need to update painter and onChange value
      _setupPainter();
      _updateOnChange();
      return;
    }

    _animationCompleted = false;

    final duration = valueToDuration(widget.initialValue,
        _oldWidgetValue ?? widget.min, widget.min, widget.max);

    _animController.duration = Duration(milliseconds: duration);

    final curvedAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _animation = Tween<double>(begin: _oldWidgetAngle ?? 0, end: widget.angle)
        .animate(curvedAnimation)
          ..addListener(() {
            setState(() {
              if (!_animationCompleted) {
                _currentAngle = _animation.value;
                // update painter and the on change closure
                _setupPainter();
                _updateOnChange();
              }
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationCompleted = true;

              _animController.reset();
              // _animController.dispose();
            }
          });
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    /// If painter is null there is a need to setup it to prevent exceptions.
    if (_painter == null) {
      _setupPainter();
      _updateOnChange();
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
        child: CustomPaint(
          painter: _painter,
          child: Container(
              width: widget.appearance.size,
              height: widget.appearance.size,
              child: _buildChildWidget()),
        ));
  }

  @override
  void dispose() {
    if (_animController != null) _animController.dispose();
    super.dispose();
  }

  void _setupPainter() {
    var defaultAngle = _currentAngle ?? widget.angle;
    if (_oldWidgetAngle != null) {
      if (_oldWidgetAngle != widget.angle) {
        _selectedAngle = null;
        defaultAngle = widget.angle;
      }
    }

    _currentAngle = calculateAngle(
        startAngle: widget.appearance.startAngle,
        angleRange: widget.appearance.angleRange,
        selectedAngle: _selectedAngle,
        previousAngle: _currentAngle,
        defaultAngle: defaultAngle);

    _painter = _CurvePainter(
        angle: _currentAngle < 0.5 ? 0.5 : _currentAngle,
        appearance: widget.appearance);
    _oldWidgetAngle = widget.angle;
    _oldWidgetValue = widget.initialValue;
  }

  void _updateOnChange() {
    if (widget.onChange != null) {
      final value = angleToValue(
          _currentAngle, widget.min, widget.max, widget.appearance.angleRange);
      widget.onChange(value);
    }
  }

  Widget _buildChildWidget() {
    final value = angleToValue(
        _currentAngle, widget.min, widget.max, widget.appearance.angleRange);
    final childWidget = widget.innerWidget != null
        ? widget.innerWidget(value)
        : SliderLabel(
            value: value,
            appearance: widget.appearance,
          );
    return childWidget;
  }

  void _onPanUpdate(Offset details) {
    if (!_isHandlerSelected) {
      return;
    }
    if (_painter.center == null) {
      return;
    }
    _handlePan(details, false);
  }

  void _onPanEnd(Offset details) {
    _handlePan(details, true);
    if (widget.onChangeEnd != null) {
      widget.onChangeEnd(angleToValue(
          _currentAngle, widget.min, widget.max, widget.appearance.angleRange));
    }

    _isHandlerSelected = false;
  }

  void _handlePan(Offset details, bool isPanEnd) {
    if (_painter.center == null) {
      return;
    }
    RenderBox renderBox = context.findRenderObject();
    var position = renderBox.globalToLocal(details);
    _selectedAngle = coordinatesToRadians(_painter.center, position);
    // setup painter with new angle values and update onChange
    _setupPainter();
    _updateOnChange();
    setState(() {});
  }

  bool _onPanDown(Offset details) {
    if (_painter == null || _interactionEnabled == false) {
      return false;
    }
    RenderBox renderBox = context.findRenderObject();
    var position = renderBox.globalToLocal(details);

    if (position == null) {
      return false;
    }

    final double touchWidth = widget.appearance.progressBarWidth >= 25.0
        ? widget.appearance.progressBarWidth
        : 25.0;

    if (isPointAlongCircle(
        position, _painter.center, _painter.radius, touchWidth)) {
      _isHandlerSelected = true;
      if (widget.onChangeStart != null) {
        widget.onChangeStart(angleToValue(_currentAngle, widget.min, widget.max,
            widget.appearance.angleRange));
      }
      _onPanUpdate(details);
    } else {
      _isHandlerSelected = false;
    }

    return _isHandlerSelected;
  }
}

class SliderLabel extends StatelessWidget {
  final double value;
  final CircularSliderAppearance appearance;
  const SliderLabel({Key key, this.value, this.appearance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: builtInfo(appearance),
    );
  }

  List<Widget> builtInfo(CircularSliderAppearance appearance) {
    var widgets = <Widget>[];
    if (appearance.infoTopLabelText != null) {
      widgets.add(Text(
        appearance.infoTopLabelText,
        style: appearance.infoTopLabelStyle,
      ));
    }
    final modifier = appearance.infoModifier(value);
    widgets.add(
      Text('$modifier', style: appearance.infoMainLabelStyle),
    );
    if (appearance.infoBottomLabelText != null) {
      widgets.add(Text(
        appearance.infoBottomLabelText,
        style: appearance.infoBottomLabelStyle,
      ));
    }
    return widgets;
  }
}
