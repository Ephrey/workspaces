import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class EmptyShopListsView extends StatelessWidget {
  final String title;
  final String subtitle;

  EmptyShopListsView({
    this.title: 'Your Shopping Lists will \n appear here.',
    this.subtitle:
        'To create Lists and Items, click either of the buttons below.',
  });

  @override
  Widget build(BuildContext context) {
    double _screenWidth = ScreenSize(context: context).width;

    double _titleSize =
        Math.percentage(percent: Numbers.five, total: _screenWidth);

    double _subTitleSize =
        (Math.percentage(percent: Numbers.four, total: _screenWidth) -
            Numbers.two);

    return PaddingView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Text(text: title, fontSize: _titleSize),
          Separator(
            dimension: Dimension.height,
            distanceAsPercent: Numbers.three,
          ),
          _Text(text: subtitle, fontSize: _subTitleSize),
        ],
      ),
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
        fontWeight: FontWeight.w500,
        color: kTextSecondaryColor,
        letterSpacing: 0.5,
        height: 1.5,
      ),
    );
  }
}
