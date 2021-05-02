import 'package:flutter/material.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Icon(
        Icons.arrow_back,
        size: Math.percentage(
          percent: Numbers.four,
          total: ScreenSize(context: context).height,
        ),
      ),
      height: Math.percentage(
        percent: Numbers.seven,
        total: ScreenSize(context: context).height,
      ),
    );
  }
}
