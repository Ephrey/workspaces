import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';

class LeadingIcon extends StatelessWidget {
  final double size;
  final Color color;

  LeadingIcon({
    Key key,
    this.size,
    this.color: BaseColors.lightBlack,
  }) : super(key: key);

  @override
  Widget build(_) {
    return Icon(Icons.people_outline, color: color, size: size);
  }
}
