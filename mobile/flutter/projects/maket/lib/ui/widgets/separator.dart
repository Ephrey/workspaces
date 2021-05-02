import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class Separator extends StatelessWidget {
  final int distanceAsPercent;
  final Dimension dimension;

  Separator({
    this.distanceAsPercent: Numbers.four,
    this.dimension: Dimension.height,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize _screenSize = ScreenSize(context: context);

    double _size = (dimension == Dimension.height)
        ? _screenSize.height
        : _screenSize.width;

    final double _percentage = Math.percentage(
      percent: distanceAsPercent,
      total: _size,
    );

    return (dimension == Dimension.height)
        ? SizedBox(height: _percentage)
        : SizedBox(width: _percentage);
  }
}
