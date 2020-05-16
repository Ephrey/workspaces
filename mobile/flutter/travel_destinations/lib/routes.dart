import 'package:flutter/material.dart';
import 'package:travel_destinations/screens/home.dart';
import 'package:travel_destinations/screens/welcome.dart';
import 'package:travel_destinations/screens/destination_details.dart';

class Routes {
  Routes._();

  static const welcome = '/';
  static const home = '/home';
  static const details = '/destination_details';

  static final routes = <String, WidgetBuilder>{
    welcome: (BuildContext context) => Welcome(),
    home: (BuildContext context) => Home(),
    details: (BuildContext context) => DestinationDetails()
  };
}
