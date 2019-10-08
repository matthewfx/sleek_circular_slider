import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget innerWidget;

  ExampleViewModel(
      {@required this.pageColors,
      @required this.appearance,
      this.min,
      this.max,
      this.value,
      this.innerWidget});
}

class ExamplePage extends StatelessWidget {
  final ExampleViewModel viewModel;
  const ExamplePage({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: viewModel.pageColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp)),
        child: SafeArea(
          child: Center(
              child: SleekCircularSlider(
            onChangeStart: (double value) {
              print(value);
            },
            onChangeEnd: (double value) {
              print(value);
            },
            innerWidget: viewModel.innerWidget,
            appearance: viewModel.appearance,
            min: viewModel.min,
            max: viewModel.max,
            initialValue: viewModel.value,
          )),
        ),
      ),
    );
  }
}

class MyTestPage extends StatelessWidget {
  const MyTestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SleekCircularSlider(
          appearance: CircularSliderAppearance(),
          onChangeEnd: (double value) {
            print(value);
          },
        ),
      ),
    );
  }
}
