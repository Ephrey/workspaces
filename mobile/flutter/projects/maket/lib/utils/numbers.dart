import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/screen_size.dart';

class Numbers {
  Numbers._();

  static const int zero = 0;
  static const int one = 1;
  static const int two = 2;
  static const int three = 3;
  static const int four = 4;
  static const int five = 5;
  static const int six = 6;
  static const int seven = 7;
  static const int eight = 8;
  static const int nine = 9;
  static const int ten = 10;
  static const int eleven = 11;
  static const int twelve = 12;
  static const int thirteen = 13;
  static const int fourteen = 14;
  static const int fifteen = 15;
  static const int sixteen = 16;
  static const int seventeen = 17;
  static const int eighteen = 18;
  static const int nineteen = 19;
  static const int twenty = 20;
  static const int twentyTwo = 22;
  static const int twentyFive = 25;
  static const int thirty = 30;
  static const int thirtyOne = 31;
  static const int thirtyTwo = 32;
  static const int thirtyThree = 33;
  static const int thirtyFour = 34;
  static const int forty = 40;
  static const int fortyTwo = 42;
  static const int fortyThree = 43;
  static const int fortyFour = 44;
  static const int fortyFive = 45;
  static const int fifty = 50;
  static const int sixty = 60;
  static const int sixtyNine = 69;
  static const int seventy = 70;
  static const int eighty = 80;
  static const int ninety = 90;
  static const int hundred = 100;
  static const int fiveHundredThousand = 500000;

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

  static String asString(int number) {
    return number.toString();
  }

  static double asDouble(int number) {
    return number.toDouble();
  }

  static int parseInt(String string) {
    return int.parse(string);
  }

  static double stringToDouble(String string) {
    return (!isDoubleNumeric(string)) ? asDouble(zero) : parseDouble(string);
  }

  static double parseDouble(dynamic value) {
    return double.parse(value);
  }

  static bool isDoubleNumeric(String value) {
    if (value == null) return false;
    return double.tryParse(value) != null;
  }

  static bool isIntNumeric(String value) {
    if (value == null) return false;
    return int.tryParse(value) != null;
  }

  static String stringAsFixed({dynamic number, int fraction: two}) {
    return number.toStringAsFixed(fraction);
  }

  static String minSpent() {
    return Numbers.stringAsFixed(number: Numbers.zero);
  }
}
