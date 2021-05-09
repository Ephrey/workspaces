import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/numbers.dart';

class NavBar extends StatelessWidget {
  final Color color;

  NavBar({this.color: kPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Icon(
        Icons.arrow_back,
        color: color,
        size: Numbers.size(context: context, percent: Numbers.four),
      ),
      height: Numbers.size(context: context, percent: Numbers.seven),
    );
  }
}
