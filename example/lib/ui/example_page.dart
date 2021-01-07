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
              callbacks: CircularSliderCallbacks(
                onChangeStart: (double value) {},
                onChangeEnd: (double value) {},
              ),
              innerWidget: viewModel.innerWidget,
              settings: viewModel.settings,
              values: viewModel.values,
              painters: CircularSliderPainters(
                backgroundPainter: (settings, values) =>
                    BackgroundPainter(settings, values),
                shadowPainter: (settings, values) =>
                    ShadowPainter(settings, values),
                progressBarPainter: (settings, values) =>
                    ProgressBarPainter(settings, values),
                currentValuePainter: (settings, values) =>
                    CurrentValuePainter(settings, values),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
