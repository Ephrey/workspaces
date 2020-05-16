import 'package:flutter/material.dart';
import 'package:travel_destinations/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.welcome,
      routes: Routes.routes,
    );
  }
}
