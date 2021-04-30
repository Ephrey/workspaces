import 'package:flutter/material.dart';

class CenteredView extends StatelessWidget {
  final Widget child;

  CenteredView({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
