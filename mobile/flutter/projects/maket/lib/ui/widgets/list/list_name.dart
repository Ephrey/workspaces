import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/numbers.dart';

class ListName extends StatelessWidget {
  final String name;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  ListName({
    @required this.name,
    this.color: kPrimaryColor,
    this.fontSize,
    this.fontWeight: FontWeight.w700,
  }) : assert(name != null);

  @override
  Widget build(BuildContext context) {
    double _fontSize = (fontSize == null)
        ? (Numbers.size(context: context, percent: Numbers.two) - Numbers.two)
        : fontSize;

    TextStyle _style = TextStyle(
      color: color,
      fontSize: _fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0.6,
    );

    return Text(name, style: _style);
  }
}
