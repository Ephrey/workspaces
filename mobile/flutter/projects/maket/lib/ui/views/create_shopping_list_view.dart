import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';

class CreateShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        child: _CreateShoppingListViewBody(),
      ),
    );
  }
}

class _CreateShoppingListViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [NavBar(), _CreateShoppingListForm()],
    );
  }
}

class _CreateShoppingListForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _form = Column(
      children: [
        FormInput(label: 'List Name'),
        Separator(),
        FormInput(label: 'Description'),
        Separator(),
        _ActionButton(),
      ],
    );

    return ExpandedView(
      child: CenteredView(child: ScrollableView(child: _form)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: "Done",
            contentPosition: Position.center,
            disabled: true,
            onPressed: () => print('Hello'),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.disable,
            text: "Next",
            icon: Icons.keyboard_arrow_right,
            iconPosition: Position.right,
            contentPosition: Position.center,
            onPressed: () => print('Hello'),
          ),
        ),
      ],
    );
  }
}
