import 'package:flutter/material.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class PaddingView extends StatelessWidget {
  final Widget child;
  final double vertical;
  final double horizontal;
  final EdgeInsets padding;

  PaddingView({
    @required this.child,
    this.horizontal,
    this.vertical: 0.0,
    this.padding,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    EdgeInsets _padding = (padding != null)
        ? padding
        : EdgeInsets.symmetric(
            horizontal: (horizontal != null)
                ? horizontal
                : Math.percentage(
                    percent: Numbers.seven,
                    total: ScreenSize(context: context).width,
                  ),
            vertical: vertical,
          );

    return Padding(padding: _padding, child: child);
  }
}
