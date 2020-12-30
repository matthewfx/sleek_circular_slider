import 'package:flutter/material.dart';
import 'settings.dart';

class SliderLabel extends StatelessWidget {
  final double value;
  final CircularSliderSettings appearance;
  const SliderLabel({Key key, this.value, this.appearance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: builtInfo(appearance),
    );
  }

  List<Widget> builtInfo(CircularSliderSettings appearance) {
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
