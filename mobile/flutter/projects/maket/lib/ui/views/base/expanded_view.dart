import 'package:flutter/material.dart';

class ExpandedView extends StatelessWidget {
  final Widget child;
  final int flex;

  ExpandedView({@required this.child, this.flex}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return (flex == null)
        ? Expanded(child: child)
        : Expanded(child: child, flex: flex);
  }
}
