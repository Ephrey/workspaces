import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/item_categories.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class CreateItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize _screenSize = ScreenSize(context: context);

    double _screenWidth = _screenSize.width;
    double _screenHeight = _screenSize.height;

    EdgeInsets _margin = EdgeInsets.all(
      (Math.percentage(percent: Numbers.four, total: _screenWidth) -
          Numbers.two),
    );

    BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(
        Math.percentage(percent: Numbers.four, total: _screenWidth),
      ),
      color: Colors.white,
    );

    return Container(
      height: Math.percentage(percent: Numbers.fifty, total: _screenHeight),
      margin: _margin,
      decoration: _boxDecoration,
      child: PaddingView(
        child: CenteredView(
          child: ScrollableView(
            child: _CreateItemForm(),
          ),
        ),
      ),
    );
  }
}

class _CreateItemForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CreateItemFormTitle(),
        Separator(),
        FormInput(label: 'Item Name'),
        Separator(),
        FormInput(
          inputType: InputType.dropdown,
          items: itemCategories,
          label: 'Item Category',
          hintText: 'Select a Category',
        ),
        Separator(),
        _CreateItemFormActionButton(),
      ],
    );
  }
}

class _CreateItemFormTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      fontSize: Math.percentage(
        percent: Numbers.seven,
        total: ScreenSize(context: context).width,
      ),
      fontWeight: FontWeight.w800,
    );

    return AlignedView(
      position: Alignment.centerLeft,
      child: Text(
        'Create an Item',
        textAlign: TextAlign.left,
        style: _textStyle,
      ),
    );
  }
}

class _CreateItemFormActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: 'Back',
            icon: Icons.keyboard_arrow_left,
            contentPosition: Position.center,
            onPressed: () {
              Navigator.of(context).pop();
              print('Back');
            },
          ),
        ),
        Separator(dimension: Dimension.width),
        Expanded(
          child: ActionButton(
            buttonType: ButtonType.primary,
            text: 'Done',
            contentPosition: Position.center,
            onPressed: () => print('Done'),
          ),
        ),
      ],
    );
  }
}
