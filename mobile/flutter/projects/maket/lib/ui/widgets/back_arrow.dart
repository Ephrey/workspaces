import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/numbers.dart';

class BackArrow extends StatelessWidget {
  final Color color;
  final double size;

  BackArrow({this.color: kPrimaryColor, this.size});

  @override
  Widget build(BuildContext context) {
    double _size = (size != null)
        ? size
        : Numbers.size(context: context, percent: Numbers.four);

    return Icon(Icons.arrow_back, color: color, size: _size);
  }
}
