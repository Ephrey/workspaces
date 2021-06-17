import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/base/circle_button.dart';
import 'package:maket/utils/numbers.dart';

class AddItemToListButton extends StatelessWidget {
  final Function onTap;

  AddItemToListButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return PaddingView(
      vertical: (Numbers.size(context: context, percent: Numbers.four)),
      horizontal: (Numbers.size(context: context, percent: Numbers.three)),
      child: AlignedView(
        child: CircleButton(
          buttonSize: (Numbers.size(context: context, percent: Numbers.eight)),
          iconColor: kTextPrimaryColor,
          icon: Icons.add,
          backgroundColor: kPrimaryColor,
          onTap: onTap,
        ),
        position: Alignment.bottomRight,
      ),
    );
  }
}
