import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/screen_size.dart';

class Numbers {
  static const zero = 0;
  static const one = 1;
  static const two = 2;
  static const three = 3;
  static const four = 4;
  static const five = 5;
  static const six = 6;
  static const seven = 7;
  static const eight = 8;
  static const nine = 9;
  static const ten = 10;
  static const eleven = 11;
  static const twelve = 12;
  static const thirteen = 13;
  static const fourteen = 14;
  static const fifteen = 15;
  static const sixteen = 16;
  static const seventeen = 17;
  static const eighteen = 18;
  static const nineteen = 19;
  static const twenty = 20;
  static const twentyTwo = 22;
  static const thirty = 30;
  static const thirtyOne = 31;
  static const thirtyTwo = 32;
  static const thirtyThree = 33;
  static const thirtyFour = 34;
  static const forty = 40;
  static const fifty = 50;
  static const sixty = 60;
  static const seventy = 70;
  static const eighty = 80;
  static const ninety = 90;

  /// Get Sizes to use for Elements such as Text font size, height, width, ...
  ///
  /// [BuildContext] the context from build function you called this method from.
  ///
  /// [percent] the screen percentage you to use as size on elements.
  ///
  /// [Dimension] the [width] or [height] the screen to use as total value.

  static double size({
    @required BuildContext context,
    @required int percent,
    Dimension dimension: Dimension.height,
  }) {
    ScreenSize _screenSize = ScreenSize(context: context);

    return Math.percentage(
      percent: percent,
      total: (dimension == Dimension.height)
          ? _screenSize.height
          : _screenSize.width,
    );
  }
}
