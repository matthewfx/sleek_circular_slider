import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderSettings settings;
  final double min;
  final double max;
  final double value;
  final InnerWidget innerWidget;

  ExampleViewModel({
    @required this.pageColors,
    @required this.settings,
    this.min = 0,
    this.max = 100,
    this.value = 50,
    this.innerWidget,
  });
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
            tileMode: TileMode.clamp,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SleekCircularSlider(
              callbacks: SliderCallbacks(
                onChangeStart: (double value) {},
                onChangeEnd: (double value) {},
              ),
              innerWidget: viewModel.innerWidget,
              settings: viewModel.settings,
              values: SliderValues(
                minimumValue: viewModel.min,
                maximumValue: viewModel.max,
                initialValue: viewModel.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
