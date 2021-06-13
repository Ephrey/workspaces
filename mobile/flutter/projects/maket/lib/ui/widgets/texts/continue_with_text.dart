import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class ContinueWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: Text(
        'or continue with',
        style: TextStyle(
          color: kTextSecondaryColor,
          fontSize: (Math.percentage(
                  percent: Numbers.four,
                  total: ScreenSize(context: context).width) -
              Numbers.two),
        ),
      ),
    );
  }
}
