import 'package:flutter/material.dart';
import 'package:travel_destinations/constants/custom_colors.dart';

class LocationName extends StatelessWidget {
  final String name;
  final double fontSize;
  final Color fontColor;

  LocationName({
    Key key,
    @required this.name,
    @required this.fontSize,
    this.fontColor: BaseColors.lightBlack,
  })  : assert(name != null, "The Location name is highly required"),
        assert(fontSize != null, "For better rendering, the FontSize is need"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle = TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );

    return Text('$name', style: _textStyle);
  }
}
