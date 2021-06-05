import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final bool centered;
  final bool withSafeArea;
  final bool safeAreaLeft;
  final bool safeAreaTop;
  final bool safeAreaRight;
  final bool safeAreaBottom;

  BaseView({
    @required this.child,
    this.centered: false,
    this.withSafeArea: true,
    this.safeAreaLeft: true,
    this.safeAreaTop: true,
    this.safeAreaRight: true,
    this.safeAreaBottom: true,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (withSafeArea)
          ? SafeArea(
              left: safeAreaLeft,
              top: safeAreaTop,
              right: safeAreaRight,
              bottom: safeAreaBottom,
              child: (centered)
                  ? CenteredView(child: ScrollableView(child: child))
                  : child,
            )
          : (centered)
              ? CenteredView(child: ScrollableView(child: child))
              : child,
    );
  }
}
