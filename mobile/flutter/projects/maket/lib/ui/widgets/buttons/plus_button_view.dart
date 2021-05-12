import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/create_shopping_list_and_item_view.dart';
import 'package:maket/ui/widgets/buttons/base/circle_button.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';
import 'package:maket/utils/show_modal.dart';

class PlusButton extends StatelessWidget {
  final Alignment position;

  PlusButton({this.position: Alignment.bottomCenter});

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
          onTap: () => showModel(
            context: context,
            child: CreateShoppingListAndItemView(),
          ),
        ),
      ),
    );
  }
}
