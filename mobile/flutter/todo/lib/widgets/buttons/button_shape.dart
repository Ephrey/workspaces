import 'package:flutter/material.dart';

class ButtonShape extends StatelessWidget {
  final Widget child;
  final BoxConstraints parentSize;
  final Color color;
  final bool hasWidth;

  ButtonShape({
    Key key,
    this.child,
    this.parentSize,
    this.color,
    this.hasWidth: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: hasWidth ? parentSize.maxWidth : null,
      height: parentSize.maxHeight * .2 + 3,
      color: color,
      child: child,
    );
  }
}
