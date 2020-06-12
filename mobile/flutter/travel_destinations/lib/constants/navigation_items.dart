import 'package:flutter/material.dart';

class Navigations {
  String name;

  Navigations({@required this.name});
}

final List<Navigations> navigations = List<Navigations>.unmodifiable([
  Navigations(name: 'For you'),
  Navigations(name: 'Upcoming trips'),
  Navigations(name: 'Popular'),
  Navigations(name: 'Recommended'),
]);
