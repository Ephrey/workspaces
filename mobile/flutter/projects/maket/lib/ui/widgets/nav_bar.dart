import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';

class NavBar extends StatelessWidget {
  final Function onTap;
  final Color color;

  NavBar({this.onTap, this.color: kPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Numbers.size(context: context, percent: Numbers.seven),
      alignment: Alignment.centerLeft,
      child: GestureHandler(
        child: Icon(
          Icons.arrow_back,
          color: color,
          size: Numbers.size(context: context, percent: Numbers.four),
        ),
        onTap: (onTap != null) ? onTap : () => pop(context: context),
      ),
    );
  }
}
