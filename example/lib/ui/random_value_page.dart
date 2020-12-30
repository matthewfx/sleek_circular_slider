import 'dart:math';
import 'package:example/utils.dart';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderColors.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderGeometry.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderShadow.dart';
import 'package:sleek_circular_slider/configuration/CircularSliderText.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RandomValuePage extends StatefulWidget {
  @override
  _RandomValuePageState createState() => _RandomValuePageState();
}

class _RandomValuePageState extends State<RandomValuePage> {
  int _currentValue = 50;

  void _generateRandomValue() {
    final randomizer = Random();
    _currentValue = randomizer.nextInt(100);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red, Colors.pink],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp)),
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SleekCircularSlider(
                    settings: settings01,
                    initialValue: _currentValue.toDouble(),
                  ),
                  MaterialButton(
                    height: 35.0,
                    highlightElevation: 2.0,
                    highlightColor: HexColor('#FED1CD'),
                    shape: StadiumBorder(),
                    color: HexColor('#FEA78D').withOpacity(0.9),
                    child: Text('New value'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: HexColor('#BD0016'))),
                    onPressed: () {
                      _generateRandomValue();
                    },
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

final geometry01 = CircularSliderGeometry(
  startAngle: 180,
  angleRange: 180,
  size: 250.0,
  trackWidth: 2,
  progressBarWidth: 20,
  shadowWidth: 50,
);

final colors01 = CircularSliderColors(
  dotColor: Colors.white.withOpacity(0.8),
  trackColor: HexColor('#FF8282').withOpacity(0.6),
  barColors: [
    HexColor('#FFE2E2').withOpacity(0.9),
    HexColor('#FFAD8D').withOpacity(0.9),
    HexColor('#FE6490').withOpacity(0.5)
  ],
);

final shadow01 = CircularSliderShadow(
  color: HexColor('#FFD7E2'),
  maxOpacity: 0.08,
);

final text01 = CircularSliderText(
  mainLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 60,
    fontWeight: FontWeight.w100,
  ),
);

final CircularSliderSettings settings01 = CircularSliderSettings(
  geometry: geometry01,
  colors: colors01,
  shadow: shadow01,
  text: text01,
);
