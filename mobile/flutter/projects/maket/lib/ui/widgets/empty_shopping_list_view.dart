import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class EmptyShopListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = ScreenSize(context: context).width;

    double _titleSize =
        Math.percentage(percent: Numbers.six, total: _screenWidth);

    double _subTitleSize =
        (Math.percentage(percent: Numbers.five, total: _screenWidth) -
            Numbers.two);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Text(
          text: 'Your Shopping Lists will \n appear here.',
          fontSize: _titleSize,
        ),
        Separator(
          dimension: Dimension.height,
          distanceAsPercent: Numbers.three,
        ),
        _Text(
          text: 'To create Lists and Items, click on the + button.',
          fontSize: _subTitleSize,
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  final double fontSize;

  const _Text({
    this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: kTextSecondaryColor,
      ),
    );
  }
}
