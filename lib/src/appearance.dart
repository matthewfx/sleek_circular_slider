import 'package:flutter/material.dart';

typedef String PercentageModifier(double percentage);

class BarColorHelper {
  static List<Color> createBarColorList(Color barColor) => [barColor, barColor];
}

class CircularSliderDefaultSettings {
  static const double defaultSize = 150;
  static const double defaultStartAngle = 150;
  static const double defaultAngleRange = 240;
}

class CircularSliderSettings {
  final double size;
  final double startAngle;
  final double angleRange;

  const CircularSliderSettings({
    this.size = CircularSliderDefaultSettings.defaultSize,
    this.startAngle = CircularSliderDefaultSettings.defaultStartAngle,
    this.angleRange = CircularSliderDefaultSettings.defaultAngleRange,
  });
}

class CircularSliderDefaultColors {
  static const Color defaultTrackColor = Color.fromRGBO(220, 190, 251, 1.0);
  static const Color defaultDotColor = Colors.white;
  static const Color defaultShadowColor = Color.fromRGBO(44, 87, 192, 1.0);

  static const List<Color> defaultBarColors = [
    Color.fromRGBO(30, 0, 59, 1.0),
    Color.fromRGBO(236, 0, 138, 1.0),
    Color.fromRGBO(98, 133, 218, 1.0),
  ];
}

class CircularSliderColors {
  final Color trackColor;
  final List<Color> trackColors;
  final Color dotColor;
  final Color shadowColor;
  final List<Color> barColors;

  const CircularSliderColors({
    this.trackColor = CircularSliderDefaultColors.defaultTrackColor,
    this.trackColors,
    this.dotColor = CircularSliderDefaultColors.defaultDotColor,
    this.shadowColor = CircularSliderDefaultColors.defaultShadowColor,
    this.barColors = CircularSliderDefaultColors.defaultBarColors,
  });
}

class CircularSliderAppearance {
  static const double _defaultGradientStartAngle = 0.0;
  static const double _defaultGradientEndAngle = 180.0;
  static const double _defaultTrackGradientStartAngle = 0.0;
  static const double _defaultTrackGradientEndAngle = 180.0;
  static const double _defaultShadowMaxOpacity = 0.2;

  static const bool _defaultDynamicGradient = false;
  static const bool _defaultHideShadow = false;

  String _defaultPercentageModifier(double value) {
    final roundedValue = value.ceil();
    return '$roundedValue %';
  }

  static const defaultSettings = CircularSliderSettings();
  static const defaultColors = CircularSliderColors();

  final CircularSliderSettings settings;
  final CircularSliderColors colors;

  final bool animationEnabled;
  final bool spinnerMode;
  final bool counterClockwise;
  final double animDurationMultiplier;
  final int spinnerDuration;
  final CustomSliderWidths customWidths;
  final CustomSliderColors customColors;
  final InfoProperties infoProperties;

  double get trackWidth => customWidths?.trackWidth ?? progressBarWidth / 4.0;
  double get progressBarWidth =>
      customWidths?.progressBarWidth ?? settings.size / 10.0;
  double get handlerSize => customWidths?.handlerSize ?? progressBarWidth / 5.0;
  double get shadowWidth => customWidths?.shadowWidth ?? progressBarWidth * 1.4;

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

  double get shadowMaxOpacity =>
      customColors?.shadowMaxOpacity ?? _defaultShadowMaxOpacity;
  double get shadowStep => customColors?.shadowStep;

  PercentageModifier get infoModifier =>
      infoProperties?.modifier ?? _defaultPercentageModifier;
  String get infoTopLabelText => infoProperties?.topLabelText;
  String get infoBottomLabelText => infoProperties?.bottomLabelText ?? null;

  TextStyle get infoMainLabelStyle =>
      infoProperties?.mainLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: settings.size / 5.0,
          color: Color.fromRGBO(30, 0, 59, 1.0));

  TextStyle get infoTopLabelStyle =>
      infoProperties?.topLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: settings.size / 10.0,
          color: Color.fromRGBO(147, 81, 120, 1.0));

  TextStyle get infoBottomLabelStyle =>
      infoProperties?.bottomLabelStyle ??
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: settings.size / 10.0,
          color: Color.fromRGBO(147, 81, 120, 1.0));

  const CircularSliderAppearance({
    this.settings = defaultSettings,
    this.colors = defaultColors,
    this.customWidths,
    this.customColors,
    this.infoProperties,
    this.animationEnabled = true,
    this.counterClockwise = false,
    this.spinnerMode = false,
    this.spinnerDuration = 1500,
    this.animDurationMultiplier = 1.0,
  });
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
  final double gradientStartAngle;
  final double gradientEndAngle;
  final double trackGradientStartAngle;
  final double trackGradientEndAngle;
  final bool dynamicGradient;
  final bool hideShadow;
  final double shadowMaxOpacity;
  final double shadowStep;

  CustomSliderColors(
      {this.gradientStartAngle,
      this.gradientEndAngle,
      this.trackGradientStartAngle,
      this.trackGradientEndAngle,
      this.hideShadow,
      this.shadowMaxOpacity,
      this.shadowStep,
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
