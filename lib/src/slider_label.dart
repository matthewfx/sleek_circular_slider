import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/src/settings/CircularSliderSettings.dart';

class SliderLabel extends StatelessWidget {
  final double value;
  final CircularSliderSettings settings;
  const SliderLabel({
    Key key,
    this.value,
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
        style: settings.text.getTopLabelStyle(settings.geometry.size),
      ));
    }
    final modifier = settings.text.modifier(value);
    widgets.add(Text(
      '$modifier',
      style: settings.text.getMainLabelStyle(settings.geometry.size),
    ));
    if (settings.text.bottomLabelText != null) {
      widgets.add(Text(
        settings.text.bottomLabelText,
        style: settings.text.getBottomLabelStyle(settings.geometry.size),
      ));
    }
    return widgets;
  }
}
