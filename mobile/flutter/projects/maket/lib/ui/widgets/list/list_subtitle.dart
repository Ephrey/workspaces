import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/numbers.dart';

class ListSubTitle extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  ListSubTitle({
    @required this.text,
    this.fontWeight: FontWeight.w400,
    this.fontSize,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    double _fontSize = (fontSize != null)
        ? fontSize
        : Numbers.size(context: context, percent: Numbers.two) - Numbers.three;

    TextStyle _style = TextStyle(
      color: kTextSecondaryColor,
      fontSize: _fontSize,
      fontWeight: fontWeight,
    );

    return Text(text, style: _style);
  }
}
