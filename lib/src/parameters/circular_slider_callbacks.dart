typedef void OnChange(double value);

class CircularSliderCallbacks {
  final OnChange onChange;
  final OnChange onChangeStart;
  final OnChange onChangeEnd;

  const CircularSliderCallbacks({
    this.onChange,
    this.onChangeStart,
    this.onChangeEnd,
  });
}
