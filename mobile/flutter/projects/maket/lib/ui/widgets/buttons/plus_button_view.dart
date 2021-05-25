import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/base/circle_button.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class PlusButton extends StatelessWidget {
  final Alignment position;
  final Function onTap;

  PlusButton({this.position: Alignment.bottomCenter, this.onTap});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = ScreenSize(context: context).width;

    return AlignedView(
      position: position,
      child: PaddingView(
        vertical: Math.percentage(percent: Numbers.six, total: _screenWidth),
        child: CircleButton(
          icon: Icons.add,
          iconColor: kTextPrimaryColor,
          buttonSize:
              Math.percentage(percent: Numbers.seventeen, total: _screenWidth),
          backgroundColor: kPrimaryColor,
          onTap: onTap,
        ),
      ),
    );
  }
}
