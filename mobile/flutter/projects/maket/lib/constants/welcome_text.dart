import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';

List<AppFeature> appFeatures = [
  AppFeature(
    title: "Shopping Made Easy",
    subtitle: "Plan and organize your shopping ahead of time in just few steps",
    icon: Icons.shopping_cart_outlined,
    color: kSuccessColor,
  ),
  AppFeature(
    title: "Create Items",
    subtitle:
        "Create Items ahead of time to make creating Shopping List soothe. The items are reusable.",
    icon: Icons.playlist_add,
    color: kTextActionColor,
  ),
  AppFeature(
    title: "Create a Shopping List",
    subtitle:
        "Set a name, description and add items to the list. Check them off when bought",
    icon: Icons.playlist_add_check_rounded,
    color: kErrorColor,
  ),
];

class AppFeature {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  AppFeature({this.title, this.subtitle, this.icon, this.color});
}
