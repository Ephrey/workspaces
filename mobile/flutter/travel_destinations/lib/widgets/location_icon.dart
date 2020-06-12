import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';

class LocationIcon extends StatelessWidget {
  final double iconSize;
  final Color iconColor;

  LocationIcon({
    Key key,
    @required this.iconSize,
    this.iconColor: BaseColors.main,
  })  : assert(iconSize != null, "The Icon Size is required Sir :)"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.location_on,
      size: iconSize,
      color: iconColor,
    );
  }
}
