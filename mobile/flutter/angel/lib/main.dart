import 'package:flutter/material.dart';
import 'package:angel/screens/welcome.dart';
import 'package:angel/screens/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Angel",
      home: Welcome(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
