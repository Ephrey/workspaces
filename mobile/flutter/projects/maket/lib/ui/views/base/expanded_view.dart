import 'package:flutter/material.dart';

class ExpandedView extends StatelessWidget {
  final Widget child;

  ExpandedView({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: child);
  }
}
