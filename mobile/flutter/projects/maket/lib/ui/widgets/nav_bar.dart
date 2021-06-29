import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/widgets/back_arrow.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/snackbar/hide_snackbar.dart';

class NavBar extends StatelessWidget {
  final Function onTap;
  final Color color;
  final double size;

  NavBar({this.onTap, this.color: kPrimaryColor, this.size});

  void _onBackArrowClick({BuildContext context}) {
    pop(context: context);
    hideSnackBar(context: context);
    if (onTap != null) onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Numbers.size(context: context, percent: Numbers.seven),
      alignment: Alignment.centerLeft,
      child: GestureHandler(
        child: BackArrow(color: color, size: size),
        onTap: () => _onBackArrowClick(context: context),
      ),
    );
  }
}
