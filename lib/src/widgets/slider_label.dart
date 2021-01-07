import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_values.dart';
import 'package:sleek_circular_slider/src/parameters/circular_slider_settings.dart';

class SliderLabel extends StatelessWidget {
  final double value;
  final CircularSliderSettings settings;
  final CircularSliderValues values;
  const SliderLabel({
    Key key,
    this.value,
    this.values,
    this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildInfo(settings),
    );
  }

  List<Widget> buildInfo(CircularSliderSettings settings) {
    var widgets = <Widget>[];
    if (settings.text.topLabelText != null) {
      widgets.add(Text(
        settings.text.topLabelText,
        style: settings.text.getTopLabelStyle(values.size),
      ));
    }
    final modifier = settings.text.modifier(value);
    widgets.add(Text(
      '$modifier',
      style: settings.text.getMainLabelStyle(values.size),
    ));
    if (settings.text.bottomLabelText != null) {
      widgets.add(Text(
        settings.text.bottomLabelText,
        style: settings.text.getBottomLabelStyle(values.size),
      ));
    }
    return widgets;
  }
}
