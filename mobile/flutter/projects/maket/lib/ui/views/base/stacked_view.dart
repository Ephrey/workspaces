import 'package:flutter/material.dart';

class StackedView extends StatelessWidget {
  final List<Widget> children;

  const StackedView({@required this.children}) : assert(children != null);

  @override
  Widget build(BuildContext context) {
    return Stack(children: children);
  }
}
