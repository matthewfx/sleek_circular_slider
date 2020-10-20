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
    CustomSliderWidths(trackWidth: 22, progressBarWidth: 20, shadowWidth: 50);
final customColors03 = CustomSliderColors(
    trackColors: [HexColor('#FFF8CB'), HexColor('#B9FFFF')],
    progressBarColors: [HexColor('#FFC84B'), HexColor('#00BFD5')],
    shadowColor: HexColor('#5FC7B0'),
    dynamicGradient: true,
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
    CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors07 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.1),
    trackColor: HexColor('#7EFFFF').withOpacity(0.2),
    progressBarColors: [
      HexColor('#17C5E5'),
      HexColor('#DFFF97'),
      HexColor('#04FFB5')
    ],
    shadowColor: HexColor('#0CA1BD'),
    shadowMaxOpacity: 0.05);

final CircularSliderAppearance appearance07 = CircularSliderAppearance(
    customWidths: customWidth07,
    customColors: customColors07,
    startAngle: 180,
    angleRange: 360,
    size: 130.0,
    spinnerMode: true);
final viewModel07 = ExampleViewModel(
    appearance: appearance07,
    value: 50,
    pageColors: [HexColor('#FFFFFF'), HexColor('#93EBEB')]);
final example07 = ExamplePage(
  viewModel: viewModel07,
);

/// Example 08
final customWidth08 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 15, shadowWidth: 50);
final customColors08 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.5),
    trackColor: HexColor('#7EFFFF').withOpacity(0.1),
    progressBarColors: [
      HexColor('#3586FC').withOpacity(0.1),
      HexColor('#FF8876').withOpacity(0.25),
      HexColor('#FAFF76').withOpacity(0.5)
    ],
    shadowColor: HexColor('#133657'),
    shadowMaxOpacity: 0.02);

final CircularSliderAppearance appearance08 = CircularSliderAppearance(
    customWidths: customWidth08,
    customColors: customColors08,
    size: 230.0,
    spinnerMode: true,
    spinnerDuration: 1000);
final viewModel08 =
    ExampleViewModel(appearance: appearance08, value: 50, pageColors: [
  HexColor('#EA875A'),
  HexColor('#9EAABB'),
  HexColor('#3272AE'),
  HexColor('#041529')
]);
final example08 = ExamplePage(
  viewModel: viewModel08,
);

/// Example 09
final customWidth09 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 15, shadowWidth: 50);
final customColors09 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.5),
    trackColor: HexColor('#000000').withOpacity(0.1),
    progressBarColors: [
      HexColor('#3586FC').withOpacity(0.1),
      HexColor('#FF8876').withOpacity(0.25),
      HexColor('#3586FC').withOpacity(0.5)
    ],
    shadowColor: HexColor('#133657'),
    shadowMaxOpacity: 0.02);

final CircularSliderAppearance appearance09 = CircularSliderAppearance(
    customWidths: customWidth09,
    customColors: customColors09,
    startAngle: 55,
    angleRange: 110,
    size: 230.0,
    counterClockwise: true);
final viewModel09 =
    ExampleViewModel(appearance: appearance09, value: 50, pageColors: [
  HexColor('#FFFFFF'),
  HexColor('#EEEEEE'),
  HexColor('#FFFFFF'),
  HexColor('#DDDDDD')
]);
final example09 = ExamplePage(
  viewModel: viewModel09,
);

/// Example 09
final customWidth10 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 28, shadowWidth: 60);
final customColors10 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.5),
    trackColor: HexColor('#000000').withOpacity(0.1),
    progressBarColors: [
      HexColor('#76E2FF').withOpacity(0.5),
      HexColor('#4E09ED').withOpacity(0.5),
      HexColor('#F7E4FF').withOpacity(0.3)
    ],
    dynamicGradient: true,
    shadowColor: HexColor('#55B3E4'),
    shadowMaxOpacity: 0.02);

final info10 = InfoProperties(
    bottomLabelStyle: TextStyle(
        color: HexColor('#5F9DF5'), fontSize: 24, fontWeight: FontWeight.w200),
    bottomLabelText: 'Volume',
    mainLabelStyle: TextStyle(
        color: HexColor('#FF6BD9'),
        fontSize: 60.0,
        fontWeight: FontWeight.w100),
    modifier: (double value) {
      final volume = value.toInt();
      return '$volume db';
    });

final CircularSliderAppearance appearance10 = CircularSliderAppearance(
    customWidths: customWidth10,
    customColors: customColors10,
    startAngle: 180,
    angleRange: 240,
    infoProperties: info10,
    size: 280.0,
    counterClockwise: true,
    animDurationMultiplier: 3);
final viewModel10 = ExampleViewModel(
    appearance: appearance10,
    min: -25,
    max: 0,
    value: -17,
    pageColors: [
      HexColor('#FFFFFF'),
      HexColor('#D7F2FD'),
      HexColor('#FFFFFF'),
      HexColor('#FFFFFF')
    ]);
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
        example10,
        RandomValuePage(),
        example03,
        example04,
        example02,
        example05,
        example09,
        example08,
        example06,
        example07,
        Clock(),
      ],
    ));
  }
}

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}
