import 'package:flutter/material.dart';

class Activities {
  String name;
  IconData icon;

  Activities({
    @required this.name,
    @required this.icon,
  });
}

List<Activities> activities = [
  Activities(
    name: 'Hiking',
    icon: Icons.directions_walk,
  ),
  Activities(
    name: 'Golf',
    icon: Icons.golf_course,
  ),
  Activities(
    name: 'Sealing',
    icon: Icons.directions_boat,
  ),
  Activities(
    name: 'Swimming',
    icon: Icons.pool,
  ),
  Activities(
    name: 'Biking',
    icon: Icons.directions_bike,
  ),
  Activities(
    name: 'Local Special',
    icon: Icons.restaurant_menu,
  ),
];
