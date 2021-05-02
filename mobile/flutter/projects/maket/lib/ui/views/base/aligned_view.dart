import 'package:flutter/material.dart';

class AlignedView extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry position;

  AlignedView({
    @required this.child,
    @required this.position,
  })  : assert(child != null),
        assert(position != null);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: position,
      child: child,
    );
  }
}
