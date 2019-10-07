import 'package:flutter/material.dart';
import 'ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleek Circular Slider',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
