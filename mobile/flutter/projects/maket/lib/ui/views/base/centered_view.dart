import 'package:flutter/material.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final bool centered;

  BaseView({@required this.child, this.centered: false})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: centered
            ? Center(child: ScrollableView(child: child))
            : PaddingView(child: child),
      ),
    );
  }
}

class ScrollableView extends StatelessWidget {
  final Widget child;

  const ScrollableView({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaddingView(
        child: child,
      ),
    );
  }
}

class PaddingView extends StatelessWidget {
  final Widget child;

  PaddingView({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Math.percentage(
          percent: Numbers.two,
          total: ScreenSize(context: context).height,
        ),
        horizontal: Math.percentage(
          percent: Numbers.seven,
          total: ScreenSize(context: context).width,
        ),
      ),
      child: child,
    );
  }
}
