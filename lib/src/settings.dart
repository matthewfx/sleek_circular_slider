import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderColors.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderFeatures.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderGeometry.dart';

typedef String PercentageModifier(double percentage);

class CircularSliderSettings {
  String _defaultPercentageModifier(double value) {
    final roundedValue = value.ceil();
    return '$roundedValue %';
  }

  static const defaultGeometry = CircularSliderGeometry();
  static const defaultColors = CircularSliderColors();
  static const defaultFeatures = CircularSliderFeatures();

  final CircularSliderGeometry geometry;
  final CircularSliderColors colors;
  final CircularSliderFeatures features;

  static const double _defaultShadowMaxOpacity = 0.2;
  double get shadowMaxOpacity =>
      customColors?.shadowMaxOpacity ?? _defaultShadowMaxOpacity;
  double get shadowStep => customColors?.shadowStep;

  final double animDurationMultiplier;
  final int spinnerDuration;
  final CustomSliderColors customColors;
  final InfoProperties infoProperties;

  PercentageModifier get infoModifier =>
      infoProperties?.modifier ?? _defaultPercentageModifier;
  String get infoTopLabelText => infoProperties?.topLabelText;
  String get infoBottomLabelText => infoProperties?.bottomLabelText ?? null;

  TextStyle get infoMainLabelStyle =>
      infoProperties?.mainLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: geometry.size / 5.0,
          color: Color.fromRGBO(30, 0, 59, 1.0));

  TextStyle get infoTopLabelStyle =>
      infoProperties?.topLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: geometry.size / 10.0,
          color: Color.fromRGBO(147, 81, 120, 1.0));

  TextStyle get infoBottomLabelStyle =>
      infoProperties?.bottomLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: geometry.size / 10.0,
          color: Color.fromRGBO(147, 81, 120, 1.0));

  const CircularSliderSettings({
    this.geometry = defaultGeometry,
    this.colors = defaultColors,
    this.features = defaultFeatures,
    this.customColors,
    this.infoProperties,
    this.spinnerDuration = 1500,
    this.animDurationMultiplier = 1.0,
  });
}

class CustomSliderColors {
  final double shadowMaxOpacity;
  final double shadowStep;

  CustomSliderColors({
    this.shadowMaxOpacity,
    this.shadowStep,
  });
}

class InfoProperties {
  final PercentageModifier modifier;
  final TextStyle mainLabelStyle;
  final TextStyle topLabelStyle;
  final TextStyle bottomLabelStyle;
  final String topLabelText;
  final String bottomLabelText;

  InfoProperties(
      {this.topLabelText,
      this.bottomLabelText,
      this.mainLabelStyle,
      this.topLabelStyle,
      this.bottomLabelStyle,
      this.modifier});
}
