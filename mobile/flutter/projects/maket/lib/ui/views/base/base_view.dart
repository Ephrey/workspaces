import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final bool centered;

  BaseView({@required this.child, this.centered: false})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (centered)
            ? CenteredView(child: ScrollableView(child: child))
            : child,
      ),
    );
  }
}
