import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/numbers.dart';

class ListName extends StatelessWidget {
  final String name;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final bool overFlow;

  ListName({
    @required this.name,
    this.color: kPrimaryColor,
    this.fontSize,
    this.fontWeight: FontWeight.w800,
    this.overFlow: true,
  }) : assert(name != null);

  @override
  Widget build(BuildContext context) {
    double _fontSize = (fontSize == null)
        ? (Numbers.size(context: context, percent: Numbers.two))
        : fontSize;

    TextStyle _style = TextStyle(
      color: color,
      fontSize: _fontSize,
      fontWeight: fontWeight,
    );

    return (overFlow)
        ? Text(name, style: _style)
        : Text(
            name,
            style: _style,
            maxLines: Numbers.one,
            overflow: TextOverflow.ellipsis,
          );
  }
}
