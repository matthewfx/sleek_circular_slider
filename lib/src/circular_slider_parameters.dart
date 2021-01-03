import 'package:flutter/material.dart';

typedef void OnChange(double value);
typedef Widget InnerWidget(double percentage);

class SliderCallbacks {
  final OnChange onChange;
  final OnChange onChangeStart;
  final OnChange onChangeEnd;

  const SliderCallbacks({
    this.onChange,
    this.onChangeStart,
    this.onChangeEnd,
  });
}

class SliderValues {
  final double initialValue;
  final double minimumValue;
  final double maximumValue;

  const SliderValues({
    this.initialValue = 50,
    this.minimumValue = 0,
    this.maximumValue = 100,
  })  : assert(initialValue != null),
        assert(minimumValue != null),
        assert(maximumValue != null),
        assert(minimumValue <= maximumValue),
        assert(initialValue >= minimumValue && initialValue <= maximumValue);
}
