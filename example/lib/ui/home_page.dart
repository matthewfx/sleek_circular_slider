import 'package:flutter/material.dart';
import 'clock_page.dart';
import 'random_value_page.dart';
import 'package:example/utils.dart';
import 'dart:math' as math;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'example_page.dart';

/// Example 01
final CircularSliderAppearance appearance01 = CircularSliderAppearance();
final viewModel01 = ExampleViewModel(
    appearance: appearance01,
    min: 0,
    max: 100,
    value: 60,
    pageColors: [Colors.white, HexColor('#E1C3FF')]);
final example01 = ExamplePage(
  viewModel: viewModel01,
);

/// Example 02
final customWidth02 = CustomSliderWidths(trackWidth: 1, progressBarWidth: 2);
final customColors02 = CustomSliderColors(
    trackColor: Colors.white,
    progressBarColor: Colors.orange,
    hideShadow: true);
final info02 = InfoProperties(
    topLabelStyle: TextStyle(
        color: Colors.orangeAccent, fontSize: 30, fontWeight: FontWeight.w600),
    topLabelText: 'Budget',
    mainLabelStyle: TextStyle(
        color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.w100),
    modifier: (double value) {
      final budget = (value * 1000).toInt();
      return '\$ $budget';
    });
final CircularSliderAppearance appearance02 = CircularSliderAppearance(
    customWidths: customWidth02,
    customColors: customColors02,
    infoProperties: info02,
    startAngle: 180,
    angleRange: 270,
    size: 200.0,
    animationEnabled: false);
final viewModel02 = ExampleViewModel(
    appearance: appearance02,
    min: 0,
    max: 10,
    value: 8,
    pageColors: [Colors.black, Colors.black87]);
final example02 = ExamplePage(
  viewModel: viewModel02,
);

/// Example 03
final customWidth03 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 20, shadowWidth: 50);
final customColors03 = CustomSliderColors(
    trackColor: HexColor('#90E3D0'),
    progressBarColors: [HexColor('#FFC84B'), HexColor('#00BFD5')],
    shadowColor: HexColor('#5FC7B0'),
    shadowMaxOpacity: 0.05);

final info03 = InfoProperties(
    bottomLabelStyle: TextStyle(
        color: HexColor('#002D43'), fontSize: 20, fontWeight: FontWeight.w700),
    bottomLabelText: 'Goal',
    mainLabelStyle: TextStyle(
        color: Color.fromRGBO(97, 169, 210, 1),
        fontSize: 30.0,
        fontWeight: FontWeight.w200),
    modifier: (double value) {
      final kcal = value.toInt();
      return '$kcal kCal';
    });
final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    infoProperties: info03,
    size: 250.0,
    startAngle: 180,
    angleRange: 340);
final viewModel03 = ExampleViewModel(
    appearance: appearance03,
    min: 500,
    max: 2300,
    value: 1623,
    pageColors: [HexColor('#D9FFF7'), HexColor('#FFFFFF')]);
final example03 = ExamplePage(
  viewModel: viewModel03,
);

/// Example 04
final customWidth04 =
    CustomSliderWidths(trackWidth: 4, progressBarWidth: 20, shadowWidth: 40);
final customColors04 = CustomSliderColors(
    trackColor: HexColor('#CCFF63'),
    progressBarColor: HexColor('#00FF89'),
    shadowColor: HexColor('#B0FFDA'),
    shadowMaxOpacity: 0.5, //);
    shadowStep: 20);
final info04 = InfoProperties(
    bottomLabelStyle: TextStyle(
        color: HexColor('#6DA100'), fontSize: 20, fontWeight: FontWeight.w600),
    bottomLabelText: 'Temp.',
    mainLabelStyle: TextStyle(
        color: HexColor('#54826D'),
        fontSize: 30.0,
        fontWeight: FontWeight.w600),
    modifier: (double value) {
      final temp = value.toInt();
      return '$temp ˚C';
    });
final CircularSliderAppearance appearance04 = CircularSliderAppearance(
    customWidths: customWidth04,
    customColors: customColors04,
    infoProperties: info04,
    startAngle: 90,
    angleRange: 90,
    size: 200.0,
    animationEnabled: true);
final viewModel04 = ExampleViewModel(
    appearance: appearance04,
    min: 0,
    max: 40,
    value: 27,
    pageColors: [Colors.white, HexColor('#F1F1F1')]);
final example04 = ExamplePage(
  viewModel: viewModel04,
);

/// Example 05
final customWidth05 =
    CustomSliderWidths(trackWidth: 4, progressBarWidth: 45, shadowWidth: 70);
final customColors05 = CustomSliderColors(
    dotColor: HexColor('#FFB1B2'),
    trackColor: HexColor('#E9585A'),
    progressBarColors: [HexColor('#FB9967'), HexColor('#E9585A')],
    shadowColor: HexColor('#FFB1B2'),
    shadowMaxOpacity: 0.05);
final info05 = InfoProperties(
    topLabelStyle: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    topLabelText: 'Elapsed',
    bottomLabelStyle: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    bottomLabelText: 'time',
    mainLabelStyle: TextStyle(
        color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.w600),
    modifier: (double value) {
      final time = printDuration(Duration(seconds: value.toInt()));
      return '$time';
    });
final CircularSliderAppearance appearance05 = CircularSliderAppearance(
    customWidths: customWidth05,
    customColors: customColors05,
    infoProperties: info05,
    startAngle: 270,
    angleRange: 360,
    size: 350.0);
final viewModel05 = ExampleViewModel(
    appearance: appearance05,
    min: 0,
    max: 86400,
    value: 67459,
    pageColors: [Colors.black, Colors.black87]);
final example05 = ExamplePage(
  viewModel: viewModel05,
);

/// Example 06
final customWidth06 =
    CustomSliderWidths(trackWidth: 4, progressBarWidth: 40, shadowWidth: 70);
final customColors06 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.1),
    trackColor: HexColor('#F9EBE0').withOpacity(0.2),
    progressBarColors: [
      HexColor('#A586EE').withOpacity(0.3),
      HexColor('#F9D3D2').withOpacity(0.3),
      HexColor('#BF79C2').withOpacity(0.3)
    ],
    shadowColor: HexColor('#7F5ED9'),
    shadowMaxOpacity: 0.05);

final CircularSliderAppearance appearance06 = CircularSliderAppearance(
    customWidths: customWidth06,
    customColors: customColors06,
    startAngle: 180,
    angleRange: 360,
    size: 300.0);
final viewModel06 = ExampleViewModel(
    innerWidget: (double value) {
      return Transform.rotate(
          angle: degreeToRadians(value),
          child: Align(
            alignment: Alignment.center,
            child: Container(
                width: value / 2.5,
                height: value / 2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        HexColor('#F9D3D2').withOpacity(value / 360),
                        HexColor('#BF79C2').withOpacity(value / 360)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(value / 6),
                  // ),
                )),
          ));
    },
    appearance: appearance06,
    min: 0,
    max: 360,
    value: 45,
    pageColors: [HexColor('#4825FF'), HexColor('#FFCAD2')]);
final example06 = ExamplePage(
  viewModel: viewModel06,
);

/// Example 07
final customWidth07 =
    CustomSliderWidths(trackWidth: 4, progressBarWidth: 40, shadowWidth: 70);
final customColors07 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.1),
    trackColor: HexColor('#F9EBE0').withOpacity(0.2),
    progressBarColors: [
      HexColor('#A586EE').withOpacity(0.3),
      HexColor('#F9D3D2').withOpacity(0.3),
      HexColor('#BF79C2').withOpacity(0.3)
    ],
    shadowColor: HexColor('#7F5ED9'),
    shadowMaxOpacity: 0.05);

final CircularSliderAppearance appearance07 = CircularSliderAppearance(
    customWidths: customWidth07,
    customColors: customColors07,
    startAngle: 180,
    angleRange: 360,
    size: 300.0);
final viewModel07 = ExampleViewModel(
    innerWidget: (double value) {
      return Transform.rotate(
          angle: degreeToRadians(value),
          child: Align(
            alignment: Alignment.center,
            child: Container(
                width: value / 2.5,
                height: value / 2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        HexColor('#F9D3D2').withOpacity(value / 360),
                        HexColor('#BF79C2').withOpacity(value / 360)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(value / 6),
                  // ),
                )),
          ));
    },
    appearance: appearance07,
    min: 0,
    max: 360,
    value: 45,
    pageColors: [HexColor('#4825FF'), HexColor('#FFCAD2')]);
final example07 = ExamplePage(
  viewModel: viewModel07,
);

String printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView(
      controller: controller,
      children: <Widget>[
        example01,
        example03,
        example04,
        example02,
        example05,
        example06,
        RandomValuePage(),
        Clock(),
      ],
    ));
  }
}

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}
