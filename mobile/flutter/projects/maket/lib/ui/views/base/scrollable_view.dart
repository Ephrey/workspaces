import 'package:flutter/material.dart';

class ScrollableView extends StatelessWidget {
  final Widget child;

  const ScrollableView({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: child,
    );
  }
}
