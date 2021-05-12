import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/dot_separator.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ListItemCountAndCreateDate extends StatelessWidget {
  final double fontSize;

  ListItemCountAndCreateDate({this.fontSize});

  @override
  Widget build(BuildContext context) {
    dynamic _separator = Separator(
      distanceAsPercent: Numbers.two,
      dimension: Dimension.width,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListSubTitle(
          text: '0 item',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        _separator,
        DotSeparator(),
        _separator,
        ListSubTitle(
          text: '10 Feb. 2021',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ],
    );
  }
}
