import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderGeometry.dart';

typedef String PercentageModifier(double percentage);

class CircularSliderText {
  final PercentageModifier modifier;
  final String topLabelText;
  final String bottomLabelText;

  final TextStyle _topLabelStyle;
  TextStyle getTopLabelStyle(double size) {
    return _topLabelStyle ??
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: FontSizeHelper.topLabelFontSize(size),
          color: Color.fromRGBO(147, 81, 120, 1.0),
        );
  }

  final TextStyle _mainLabelStyle;
  TextStyle getMainLabelStyle(double size) {
    return _mainLabelStyle ??
        TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: FontSizeHelper.mainLabelFontSize(size),
          color: Color.fromRGBO(30, 0, 59, 1.0),
        );
  }

  final TextStyle _bottomLabelStyle;
  TextStyle getBottomLabelStyle(double size) {
    return _bottomLabelStyle ??
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: FontSizeHelper.bottomLabelFontSize(size),
          color: Color.fromRGBO(147, 81, 120, 1.0),
        );
  }

  const CircularSliderText({
    CircularSliderGeometry geometry,
    TextStyle topLabelStyle,
    TextStyle mainLabelStyle,
    TextStyle bottomLabelStyle,
    this.topLabelText,
    this.bottomLabelText,
    this.modifier = DefaultText.percentageModifier,
  })  : this._topLabelStyle = topLabelStyle,
        this._mainLabelStyle = mainLabelStyle,
        this._bottomLabelStyle = bottomLabelStyle;
}

class DefaultText {
  static String percentageModifier(double value) {
    final roundedValue = value.ceil();
    return '$roundedValue %';
  }
}

class FontSizeHelper {
  static double mainLabelFontSize(double size) => size / 5.0;
  static double topLabelFontSize(double size) => size / 10.0;
  static double bottomLabelFontSize(double size) => size / 10.0;
}
