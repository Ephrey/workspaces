import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';

class DepartureTime extends StatelessWidget {
  final String time;
  final double fontSize;
  final double iconSize;
  final IconData timeIcon;
  final Color fontColor;
  final Color iconColor;
  final double space;

  DepartureTime({
    Key key,
    @required this.time,
    @required this.fontSize,
    @required this.iconSize,
    this.timeIcon: Icons.access_time,
    this.fontColor: BaseColors.textBlack,
    this.iconColor: BaseColors.lightBlack,
    this.space: 5.0,
  }) : super(key: key);

  @override
  Widget build(_) {
    final _style = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: fontColor,
    );

    return Row(
      children: <Widget>[
        Icon(timeIcon, color: iconColor, size: iconSize),
        SizedBox(width: space),
        Text('$time', style: _style),
      ],
    );
  }
}
