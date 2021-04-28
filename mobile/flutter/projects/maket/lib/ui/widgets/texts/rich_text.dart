import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class TextRich extends StatelessWidget {
  final String mainText;
  final String richText;
  final Color mainTextColor;
  final Function onTap;

  TextRich({
    this.mainText,
    this.richText,
    this.mainTextColor: kPrimaryColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$mainText ? ',
        style: TextStyle(
          color: mainTextColor,
          fontSize: (Math.percentage(
                percent: Numbers.fore,
                total: ScreenSize(context: context).width,
              ) -
              Numbers.two),
        ),
        children: [
          TextSpan(
            text: '$richText.',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
