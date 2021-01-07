typedef void OnChange(double value);

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
