import 'package:flutter/material.dart';

typedef String PercentageModifier(double percentage);

class CircularSliderText {
  final String? topLabelText;
  final String? bottomLabelText;

  final TextStyle? _topLabelStyle;
  TextStyle getTopLabelStyle(double size) =>
      _topLabelStyle ?? DefaultText.topLabelStyle(size);

  final TextStyle? _mainLabelStyle;
  TextStyle getMainLabelStyle(double size) =>
      _mainLabelStyle ?? DefaultText.mainLabelStyle(size);

  final TextStyle? _bottomLabelStyle;
  TextStyle getBottomLabelStyle(double size) =>
      _bottomLabelStyle ?? DefaultText.bottomLabelStyle(size);

  final PercentageModifier modifier;

  const CircularSliderText({
    TextStyle? topLabelStyle,
    TextStyle? mainLabelStyle,
    TextStyle? bottomLabelStyle,
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

  static TextStyle topLabelStyle(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size / 10.0,
        color: Color.fromRGBO(147, 81, 120, 1.0),
      );

  static TextStyle mainLabelStyle(double size) => TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: size / 5.0,
        color: Color.fromRGBO(30, 0, 59, 1.0),
      );

  static TextStyle bottomLabelStyle(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size / 10.0,
        color: Color.fromRGBO(147, 81, 120, 1.0),
      );
}
