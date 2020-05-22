import 'package:flutter/material.dart';

class Navigations {
  String name;

  Navigations({@required this.name});
}

List<Navigations> navigations = [
  Navigations(name: 'For you'),
  Navigations(name: 'Upcoming trips'),
  Navigations(name: 'Popular'),
  Navigations(name: 'Recommended'),
];
