import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/create_item_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';
import 'package:maket/utils/show_modal.dart';

class CreateShoppingListAndItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize _screenSize = ScreenSize(context: context);

    double _screenWidth = _screenSize.width;
    double _screenHeight = _screenSize.height;

    BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(
        Math.percentage(percent: Numbers.four, total: _screenWidth),
      ),
      color: Colors.white,
    );

    EdgeInsets _margin = EdgeInsets.all(
      (Math.percentage(percent: Numbers.four, total: _screenWidth) -
          Numbers.two),
    );

    return Container(
      height: Math.percentage(percent: Numbers.thirty, total: _screenHeight),
      margin: _margin,
      decoration: _boxDecoration,
      child: _CreateShoppingListAndItemViewBody(),
    );
  }
}

class _CreateShoppingListAndItemViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingView(
      child: _CreateShoppingListAndItemButtons(),
    );
  }
}

class _CreateShoppingListAndItemButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionButton(
          buttonType: ButtonType.primary,
          text: 'Create a List',
          contentPosition: Position.center,
          onPressed: () => print('Create a List'),
        ),
        Separator(),
        ActionButton(
          buttonType: ButtonType.secondary,
          text: 'Create an Item',
          contentPosition: Position.center,
          onPressed: () => showModel(
            context: context,
            child: CreateItemView(),
            isScrollControlled: true,
          ),
        ),
      ],
    );
  }
}
