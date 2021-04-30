import 'package:flutter/material.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class PaddingView extends StatelessWidget {
  final Widget child;

  PaddingView({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Math.percentage(
          percent: Numbers.seven,
          total: ScreenSize(context: context).width,
        ),
      ),
      child: child,
    );
  }
}
