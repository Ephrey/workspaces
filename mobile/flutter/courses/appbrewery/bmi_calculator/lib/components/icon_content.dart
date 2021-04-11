import 'package:bmi_calculator/utils/constants.dart';
import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;

  IconContent({@required this.icon, this.label});

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: kIconContentSize),
        SizedBox(height: kSeparatorSize),
        Text(label, style: kLabelStyle),
      ],
    );
  }
}
