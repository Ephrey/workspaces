import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Function onTap;
  final double buttonSize;
  final bool isLoading;

  const CircleButton({
    @required this.icon,
    this.iconColor: kPrimaryColor,
    this.backgroundColor: kBgPrimaryColor,
    this.onTap,
    this.buttonSize,
    this.isLoading: false,
  }) : assert(icon != null);

  @override
  Widget build(BuildContext context) {
    double _buttonSize = (buttonSize != null)
        ? buttonSize
        : (Math.percentage(
                percent: Numbers.fourteen,
                total: ScreenSize(context: context).width) -
            Numbers.two);

    double _iconSize =
        (Math.percentage(percent: Numbers.seventy, total: _buttonSize) -
            Numbers.three);

    BoxDecoration _boxDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(100.0),
      boxShadow: [
        BoxShadow(color: kElevationColor, blurRadius: 20.0, spreadRadius: 10.0),
      ],
    );

    return GestureDetector(
      onTap: (isLoading) ? null : onTap,
      child: Container(
        width: _buttonSize,
        height: _buttonSize,
        decoration: _boxDecoration,
        child: (isLoading)
            ? Loading()
            : Icon(icon, color: iconColor, size: _iconSize),
      ),
    );
  }
}
