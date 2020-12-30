import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderColors.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderFeatures.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderGeometry.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderShadow.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderText.dart';
import 'clock_page.dart';
import 'random_value_page.dart';
import 'package:example/utils.dart';
import 'dart:math' as math;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'example_page.dart';

/// Example 01
final settings01 = CircularSliderSettings();

final viewModel01 = ExampleViewModel(
  settings: settings01,
  min: 0,
  max: 100,
  value: 60,
  pageColors: [Colors.white, HexColor('#E1C3FF')],
);

final example01 = ExamplePage(
  viewModel: viewModel01,
);

/// Example 02
final features02 = CircularSliderFeatures(
  animationEnabled: false,
);

final geometry02 = CircularSliderGeometry(
  startAngle: 180,
  angleRange: 270,
  size: 200.0,
  trackWidth: 1,
  progressBarWidth: 2,
);

final colors02 = CircularSliderColors(
  trackColor: Colors.white,
  barColors: BarColorHelper.createBarColorList(Colors.orange),
);

final text02 = CircularSliderText(
  topLabelStyle: TextStyle(
    color: Colors.orangeAccent,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  ),
  topLabelText: 'Budget',
  mainLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 50.0,
    fontWeight: FontWeight.w100,
  ),
  modifier: (double value) {
    final budget = (value * 1000).toInt();
    return '\$ $budget';
  },
);

final shadow02 = CircularSliderShadow(
  hideShadow: true,
);

final settings02 = CircularSliderSettings(
  features: features02,
  geometry: geometry02,
  colors: colors02,
  text: text02,
  shadow: shadow02,
);

final viewModel02 = ExampleViewModel(
  settings: settings02,
  min: 0,
  max: 10,
  value: 8,
  pageColors: [Colors.black, Colors.black87],
);

final example02 = ExamplePage(
  viewModel: viewModel02,
);

/// Example 03
final geometry03 = CircularSliderGeometry(
  size: 250.0,
  startAngle: 180,
  angleRange: 340,
  trackWidth: 22,
  progressBarWidth: 20,
  shadowWidth: 50,
);

final colors03 = CircularSliderColors(
  trackColors: [HexColor('#FFF8CB'), HexColor('#B9FFFF')],
  barColors: [HexColor('#FFC84B'), HexColor('#00BFD5')],
  dynamicGradient: true,
);

final shadow03 = CircularSliderShadow(
  color: HexColor('#5FC7B0'),
  maxOpacity: 0.05,
);

final text03 = CircularSliderText(
  bottomLabelStyle: TextStyle(
    color: HexColor('#002D43'),
    fontSize: 20,
    fontWeight: FontWeight.w700,
  ),
  bottomLabelText: 'Goal',
  mainLabelStyle: TextStyle(
    color: Color.fromRGBO(97, 169, 210, 1),
    fontSize: 30.0,
    fontWeight: FontWeight.w200,
  ),
  modifier: (double value) {
    final kcal = value.toInt();
    return '$kcal kCal';
  },
);

final settings03 = CircularSliderSettings(
  geometry: geometry03,
  colors: colors03,
  shadow: shadow03,
  text: text03,
);

final viewModel03 = ExampleViewModel(
  settings: settings03,
  min: 500,
  max: 2300,
  value: 1623,
  pageColors: [HexColor('#D9FFF7'), HexColor('#FFFFFF')],
);

final example03 = ExamplePage(
  viewModel: viewModel03,
);

/// Example 04
final geometry04 = CircularSliderGeometry(
  startAngle: 90,
  angleRange: 90,
  size: 200.0,
  trackWidth: 4,
  progressBarWidth: 20,
  shadowWidth: 40,
);

final colors04 = CircularSliderColors(
  trackColor: HexColor('#CCFF63'),
  barColors: BarColorHelper.createBarColorList(HexColor('#00FF89')),
);

final shadow04 = CircularSliderShadow(
  color: HexColor('#B0FFDA'),
  maxOpacity: 0.5,
  step: 20,
);

final text04 = CircularSliderText(
  bottomLabelStyle: TextStyle(
    color: HexColor('#6DA100'),
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
  bottomLabelText: 'Temp.',
  mainLabelStyle: TextStyle(
    color: HexColor('#54826D'),
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
  ),
  modifier: (double value) {
    final temp = value.toInt();
    return '$temp ˚C';
  },
);

final settings04 = CircularSliderSettings(
  geometry: geometry04,
  colors: colors04,
  shadow: shadow04,
  text: text04,
);

final viewModel04 = ExampleViewModel(
  settings: settings04,
  min: 0,
  max: 40,
  value: 27,
  pageColors: [Colors.white, HexColor('#F1F1F1')],
);

final example04 = ExamplePage(
  viewModel: viewModel04,
);

/// Example 05
final geometry05 = CircularSliderGeometry(
  startAngle: 270,
  angleRange: 360,
  size: 350.0,
  trackWidth: 4,
  progressBarWidth: 45,
  shadowWidth: 70,
);

final colors05 = CircularSliderColors(
  dotColor: HexColor('#FFB1B2'),
  trackColor: HexColor('#E9585A'),
  barColors: [HexColor('#FB9967'), HexColor('#E9585A')],
);

final shadow05 = CircularSliderShadow(
  color: HexColor('#FFB1B2'),
  maxOpacity: 0.05,
);

final text05 = CircularSliderText(
  topLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  topLabelText: 'Elapsed',
  bottomLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bottomLabelText: 'time',
  mainLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 50.0,
    fontWeight: FontWeight.w600,
  ),
  modifier: (double value) {
    final time = printDuration(Duration(seconds: value.toInt()));
    return '$time';
  },
);

final settings05 = CircularSliderSettings(
  geometry: geometry05,
  colors: colors05,
  shadow: shadow05,
  text: text05,
);

final viewModel05 = ExampleViewModel(
    settings: settings05,
    min: 0,
    max: 86400,
    value: 67459,
    pageColors: [Colors.black, Colors.black87]);
final example05 = ExamplePage(
  viewModel: viewModel05,
);

/// Example 06
final geometry06 = CircularSliderGeometry(
  startAngle: 180,
  angleRange: 360,
  size: 300.0,
  trackWidth: 4,
  progressBarWidth: 40,
  shadowWidth: 70,
);

final colors06 = CircularSliderColors(
  dotColor: Colors.white.withOpacity(0.1),
  trackColor: HexColor('#F9EBE0').withOpacity(0.2),
  barColors: [
    HexColor('#A586EE').withOpacity(0.3),
    HexColor('#F9D3D2').withOpacity(0.3),
    HexColor('#BF79C2').withOpacity(0.3)
  ],
);

final shadow06 = CircularSliderShadow(
  color: HexColor('#7F5ED9'),
  maxOpacity: 0.05,
);

final settings06 = CircularSliderSettings(
  geometry: geometry06,
  colors: colors06,
  shadow: shadow06,
);

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
            ),
          ),
        ),
      );
    },
    settings: settings06,
    min: 0,
    max: 360,
    value: 45,
    pageColors: [HexColor('#4825FF'), HexColor('#FFCAD2')]);

final example06 = ExamplePage(
  viewModel: viewModel06,
);

/// Example 07
final features07 = CircularSliderFeatures(
  spinnerMode: true,
);

final geometry07 = CircularSliderGeometry(
  startAngle: 180,
  angleRange: 360,
  size: 130.0,
  trackWidth: 2,
  progressBarWidth: 10,
  shadowWidth: 20,
);

final colors07 = CircularSliderColors(
  dotColor: Colors.white.withOpacity(0.1),
  trackColor: HexColor('#7EFFFF').withOpacity(0.2),
  barColors: [HexColor('#17C5E5'), HexColor('#DFFF97'), HexColor('#04FFB5')],
);

final shadow07 = CircularSliderShadow(
  color: HexColor('#0CA1BD'),
  maxOpacity: 0.05,
);

final settings07 = CircularSliderSettings(
  features: features07,
  geometry: geometry07,
  colors: colors07,
  shadow: shadow07,
);

final viewModel07 = ExampleViewModel(
  settings: settings07,
  value: 50,
  pageColors: [HexColor('#FFFFFF'), HexColor('#93EBEB')],
);

final example07 = ExamplePage(
  viewModel: viewModel07,
);

/// Example 08
final features08 = CircularSliderFeatures(
  spinnerMode: true,
  spinnerDuration: 1000,
);

final geometry08 = CircularSliderGeometry(
  size: 230.0,
  trackWidth: 1,
  progressBarWidth: 15,
  shadowWidth: 50,
);

final colors08 = CircularSliderColors(
  dotColor: Colors.white.withOpacity(0.5),
  trackColor: HexColor('#7EFFFF').withOpacity(0.1),
  barColors: [
    HexColor('#3586FC').withOpacity(0.1),
    HexColor('#FF8876').withOpacity(0.25),
    HexColor('#FAFF76').withOpacity(0.5)
  ],
);

final shadow08 = CircularSliderShadow(
  color: HexColor('#133657'),
  maxOpacity: 0.02,
);

final settings08 = CircularSliderSettings(
  features: features08,
  geometry: geometry08,
  colors: colors08,
  shadow: shadow08,
);

final viewModel08 = ExampleViewModel(
  settings: settings08,
  value: 50,
  pageColors: [
    HexColor('#EA875A'),
    HexColor('#9EAABB'),
    HexColor('#3272AE'),
    HexColor('#041529')
  ],
);

final example08 = ExamplePage(
  viewModel: viewModel08,
);

/// Example 09
final features09 = CircularSliderFeatures(
  counterClockwise: true,
);

final geometry09 = CircularSliderGeometry(
  startAngle: 55,
  angleRange: 110,
  size: 230.0,
  trackWidth: 1,
  progressBarWidth: 15,
  shadowWidth: 50,
);

final colors09 = CircularSliderColors(
  dotColor: Colors.white.withOpacity(0.5),
  trackColor: HexColor('#000000').withOpacity(0.1),
  barColors: [
    HexColor('#3586FC').withOpacity(0.1),
    HexColor('#FF8876').withOpacity(0.25),
    HexColor('#3586FC').withOpacity(0.5)
  ],
);

final shadow09 = CircularSliderShadow(
  color: HexColor('#133657'),
  maxOpacity: 0.02,
);

final settings09 = CircularSliderSettings(
  features: features09,
  geometry: geometry09,
  colors: colors09,
  shadow: shadow09,
);

final viewModel09 = ExampleViewModel(
  settings: settings09,
  value: 50,
  pageColors: [
    HexColor('#FFFFFF'),
    HexColor('#EEEEEE'),
    HexColor('#FFFFFF'),
    HexColor('#DDDDDD')
  ],
);

final example09 = ExamplePage(
  viewModel: viewModel09,
);

/// Example 10
final features10 = CircularSliderFeatures(
  counterClockwise: true,
  animationDurationMultiplier: 3,
);

final geometry10 = CircularSliderGeometry(
  startAngle: 180,
  angleRange: 240,
  size: 280.0,
  trackWidth: 1,
  progressBarWidth: 28,
  shadowWidth: 60,
);

final colors10 = CircularSliderColors(
  dotColor: Colors.white.withOpacity(0.5),
  trackColor: HexColor('#000000').withOpacity(0.1),
  barColors: [
    HexColor('#76E2FF').withOpacity(0.5),
    HexColor('#4E09ED').withOpacity(0.5),
    HexColor('#F7E4FF').withOpacity(0.3)
  ],
  dynamicGradient: true,
);

final shadow10 = CircularSliderShadow(
  color: HexColor('#55B3E4'),
  maxOpacity: 0.02,
);

final text10 = CircularSliderText(
  bottomLabelStyle: TextStyle(
    color: HexColor('#5F9DF5'),
    fontSize: 24,
    fontWeight: FontWeight.w200,
  ),
  bottomLabelText: 'Volume',
  mainLabelStyle: TextStyle(
    color: HexColor('#FF6BD9'),
    fontSize: 60.0,
    fontWeight: FontWeight.w100,
  ),
  modifier: (double value) {
    final volume = value.toInt();
    return '$volume db';
  },
);

final settings10 = CircularSliderSettings(
  features: features10,
  geometry: geometry10,
  colors: colors10,
  shadow: shadow10,
  text: text10,
);

final viewModel10 = ExampleViewModel(
  settings: settings10,
  min: -25,
  max: 0,
  value: -17,
  pageColors: [
    HexColor('#FFFFFF'),
    HexColor('#D7F2FD'),
    HexColor('#FFFFFF'),
    HexColor('#FFFFFF')
  ],
);

final example10 = ExamplePage(
  viewModel: viewModel10,
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
        example02,
        example03,
        example04,
        example05,
        example06,
        example07,
        example08,
        example09,
        example10,
        RandomValuePage(),
        Clock(),
      ],
    ));
  }
}

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}
