import 'package:flutter/material.dart';
import 'ui/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleek Circular Slider',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
