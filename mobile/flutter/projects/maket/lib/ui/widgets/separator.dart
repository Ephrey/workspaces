import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class Separator extends StatelessWidget {
  final int distanceAsPercent;
  final Dimension dimension;

  Separator({
    this.distanceAsPercent: Numbers.fore,
    this.dimension: Dimension.height,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = Math.percentage(
      percent: distanceAsPercent,
      total: ScreenSize(context: context).height,
    );

    return (dimension == Dimension.height)
        ? SizedBox(height: percentage)
        : SizedBox(width: percentage);
  }
}
