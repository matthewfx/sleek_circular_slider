import 'package:flutter/material.dart';

class CircularSliderValues {
  final double initialValue;
  final double minimumValue;
  final double maximumValue;

  final double size;
  final double startAngle;
  final double currentAngle;
  final double angleRange;

  final double? _progressBarWidth;
  double get progressBarWidth =>
      _progressBarWidth ?? DefaultValues.progressBarWidth(size);

  final double? _trackWidth;
  double get trackWidth =>
      _trackWidth ?? DefaultValues.trackWidth(progressBarWidth);

  final double? _handlerSize;
  double get handlerSize =>
      _handlerSize ?? DefaultValues.handlerSize(progressBarWidth);

  Offset get center => Offset(size / 2, size / 2);
  double get radius => size / 2 - progressBarWidth / 2;

  const CircularSliderValues({
    this.initialValue = DefaultValues.initialValue,
    this.minimumValue = DefaultValues.minimumValue,
    this.maximumValue = DefaultValues.maximumValue,
    this.size = DefaultValues.size,
    this.startAngle = DefaultValues.startAngle,
    this.currentAngle = DefaultValues.startAngle,
    this.angleRange = DefaultValues.angleRange,
    double? trackWidth,
    double? progressBarWidth,
    double? handlerSize,
  })  : assert(minimumValue <= maximumValue),
        assert(initialValue >= minimumValue && initialValue <= maximumValue),
        _trackWidth = trackWidth,
        _progressBarWidth = progressBarWidth,
        _handlerSize = handlerSize;
}

class DefaultValues {
  static const double initialValue = 50;
  static const double minimumValue = 0;
  static const double maximumValue = 100;
  static const double size = 150;
  static const double startAngle = 150;
  static const double angleRange = 240;

  static double progressBarWidth(double size) => size / 10.0;
  static double trackWidth(double progressBarWidth) => progressBarWidth / 4.0;
  static double handlerSize(double progressBarWidth) => progressBarWidth / 5.0;
}
