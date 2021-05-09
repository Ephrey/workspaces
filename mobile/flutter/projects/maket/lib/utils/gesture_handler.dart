import 'package:flutter/material.dart';

class GestureHandler extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Function onLongPress;

  const GestureHandler({
    @required this.child,
    this.onTap,
    this.onLongPress,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
