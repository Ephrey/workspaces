import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';

class ServicesModel {
  String name;
  Color color;
  IconData icon;

  ServicesModel({
    this.name,
    this.color,
    this.icon,
  });
}

final List<ServicesModel> servicesModel = [
  ServicesModel(
    name: 'Baby Sister',
    color: BaseColors.babySister,
    icon: Icons.child_friendly,
  ),
  ServicesModel(
    name: 'Floor Cleaning',
    color: BaseColors.floorCleaning,
    icon: Icons.blur_on,
  ),
  ServicesModel(
    name: 'Electrician',
    color: BaseColors.electrician,
    icon: Icons.lightbulb_outline,
  ),
];
