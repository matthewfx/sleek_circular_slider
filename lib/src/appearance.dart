import 'package:flutter/material.dart';

typedef String PercentageModifier(double percentage);

class CircularSliderAppearance {
  static const double _defaultSize = 150.0;
  static const double _defaultStartAngle = 150.0;
  static const double _defaultAngleRange = 240.0;
  static const double _defaultGradientStartAngle = 0.0;
  static const double _defaultGradientEndAngle = 180.0;
  static const double _defaultTrackGradientStartAngle = 0.0;
  static const double _defaultTrackGradientEndAngle = 180.0;

  static const List<Color> _defaultBarColors = [
    Color.fromRGBO(30, 0, 59, 1.0),
    Color.fromRGBO(236, 0, 138, 1.0),
    Color.fromRGBO(98, 133, 218, 1.0),
  ];
  static const Color _defaultTrackColor = Color.fromRGBO(220, 190, 251, 1.0);
  static const Color _defaultDotColor = Colors.white;
  static const Color _defaultShadowColor = Color.fromRGBO(44, 87, 192, 1.0);
  static const double _defaultShadowMaxOpacity = 0.2;

  static const bool _defaultDynamicGradient = false;
  static const bool _defaultHideShadow = false;

  String _defaultPercentageModifier(double value) {
    final roundedValue = value.ceil();
    return '$roundedValue %';
  }

  final double size;
  final double startAngle;
  final double angleRange;

  final bool animationEnabled;
  final bool spinnerMode;
  final bool counterClockwise;
  final double animDurationMultiplier;
  final int spinnerDuration;
  final CustomSliderWidths customWidths;
  final CustomSliderColors customColors;
  final InfoProperties infoProperties;

  double get trackWidth => customWidths?.trackWidth ?? progressBarWidth / 4.0;
  double get progressBarWidth => customWidths?.progressBarWidth ?? size / 10.0;
  double get handlerSize => customWidths?.handlerSize ?? progressBarWidth / 5.0;
  double get shadowWidth => customWidths?.shadowWidth ?? progressBarWidth * 1.4;

  Color get _customTrackColor =>
      customColors != null ? customColors.trackColor : null;
  List<Color> get _customProgressBarColors {
    if (customColors != null) {
      if (customColors.progressBarColors != null) {
        return customColors.progressBarColors;
      } else if (customColors.progressBarColor != null) {
        return [customColors.progressBarColor, customColors.progressBarColor];
      }
    }
    return null;
  }

  List<Color> get _customTrackColors => customColors?.trackColors;

  Color get trackColor => _customTrackColor ?? _defaultTrackColor;
  List<Color> get trackColors => _customTrackColors ?? null;
  List<Color> get progressBarColors =>
      _customProgressBarColors ?? _defaultBarColors;
  double get gradientStartAngle =>
      customColors?.gradientStartAngle ?? _defaultGradientStartAngle;
  double get gradientStopAngle =>
      customColors?.gradientEndAngle ?? _defaultGradientEndAngle;
  double get trackGradientStartAngle =>
      customColors?.trackGradientStartAngle ?? _defaultTrackGradientStartAngle;
  double get trackGradientStopAngle =>
      customColors?.trackGradientEndAngle ?? _defaultTrackGradientEndAngle;
  bool get dynamicGradient =>
      customColors?.dynamicGradient ?? _defaultDynamicGradient;
  bool get hideShadow => customColors?.hideShadow ?? _defaultHideShadow;
  Color get shadowColor => customColors?.shadowColor ?? _defaultShadowColor;
  double get shadowMaxOpacity =>
      customColors?.shadowMaxOpacity ?? _defaultShadowMaxOpacity;
  double get shadowStep => customColors.shadowStep;
  Color get dotColor => customColors?.dotColor ?? _defaultDotColor;

  PercentageModifier get infoModifier =>
      infoProperties?.modifier ?? _defaultPercentageModifier;
  String get infoTopLabelText => infoProperties?.topLabelText;
  String get infoBottomLabelText => infoProperties?.bottomLabelText ?? null;

  TextStyle get infoMainLabelStyle =>
      infoProperties?.mainLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: size / 5.0,
          color: Color.fromRGBO(30, 0, 59, 1.0));

  TextStyle get infoTopLabelStyle =>
      infoProperties?.topLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: size / 10.0,
          color: Color.fromRGBO(147, 81, 120, 1.0));

  TextStyle get infoBottomLabelStyle =>
      infoProperties?.bottomLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: size / 10.0,
          color: Color.fromRGBO(147, 81, 120, 1.0));

  const CircularSliderAppearance(
      {this.customWidths,
      this.customColors,
      this.size = _defaultSize,
      this.startAngle = _defaultStartAngle,
      this.angleRange = _defaultAngleRange,
      this.infoProperties,
      this.animationEnabled = true,
      this.counterClockwise = false,
      this.spinnerMode = false,
      this.spinnerDuration = 1500,
      this.animDurationMultiplier = 1.0});
}

class CustomSliderWidths {
  final double trackWidth;
  final double progressBarWidth;
  final double handlerSize;
  final double shadowWidth;

  CustomSliderWidths(
      {this.trackWidth,
      this.progressBarWidth,
      this.handlerSize,
      this.shadowWidth});
}

class CustomSliderColors {
  final Color trackColor;
  final Color progressBarColor;
  final List<Color> progressBarColors;
  final double gradientStartAngle;
  final double gradientEndAngle;
  final List<Color> trackColors;
  final double trackGradientStartAngle;
  final double trackGradientEndAngle;
  final bool dynamicGradient;
  final bool hideShadow;
  final Color shadowColor;
  final double shadowMaxOpacity;
  final double shadowStep;
  final Color dotColor;

  CustomSliderColors(
      {this.trackColor,
      this.progressBarColor,
      this.progressBarColors,
      this.gradientStartAngle,
      this.gradientEndAngle,
      this.trackColors,
      this.trackGradientStartAngle,
      this.trackGradientEndAngle,
      this.hideShadow,
      this.shadowColor,
      this.shadowMaxOpacity,
      this.shadowStep,
      this.dotColor,
      this.dynamicGradient = false});
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
