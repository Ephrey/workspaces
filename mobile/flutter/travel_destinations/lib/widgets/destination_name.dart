import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';

class DestinationName extends StatelessWidget {
  final String name;
  final double size;
  final Color color;

  DestinationName({
    Key key,
    @required this.name,
    @required this.size,
    this.color: BaseColors.textBlack,
  }) : super(key: key);

  @override
  Widget build(_) {
    final TextStyle _style = TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
    );

    return Text('$name', style: _style);
  }
}
