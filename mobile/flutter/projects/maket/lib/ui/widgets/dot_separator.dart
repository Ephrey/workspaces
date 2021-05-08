import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/numbers.dart';

class DotSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Numbers.four.toDouble(),
      width: Numbers.four.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: kTextSecondaryColor,
      ),
    );
  }
}
