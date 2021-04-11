import 'package:flutter/material.dart';

import 'screen0.dart';
import 'screen1.dart';
import 'screen2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => Screen0(),
        'screen1': (BuildContext context) => Screen1(),
        'screen2': (BuildContext context) => Screen2(),
      },
    );
  }
}
