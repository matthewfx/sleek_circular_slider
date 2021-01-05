import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderSettings settings;
  final CircularSliderValues values;
  final InnerWidget innerWidget;

  ExampleViewModel({
    @required this.pageColors,
    @required this.settings,
    @required this.values,
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
              values: viewModel.values,
              painters: SliderPainters(
                backgroundPainter: (settings, values, painter) =>
                    BackgroundPainter(settings, values, painter),
                shadowPainter: (settings, values, painter) =>
                    ShadowPainter(settings, values, painter),
                progressBarPainter: (settings, values, painter) =>
                    ProgressBarPainter(settings, values, painter),
                currentValuePainter: (settings, values, painter) =>
                    CurrentValuePainter(settings, values),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
