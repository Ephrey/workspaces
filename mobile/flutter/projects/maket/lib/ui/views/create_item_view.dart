import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/item_categories.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/main_title.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/separator.dart';

class CreateItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelContainer(
      content: ScrollableView(
        child: _CreateItemForm(),
      ),
    );
  }
}

class _CreateItemForm extends StatefulWidget {
  @override
  __CreateItemFormState createState() => __CreateItemFormState();
}

class __CreateItemFormState extends State<_CreateItemForm> {
  GlobalKey<FormState> _createItemFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createItemFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTitle(text: 'Create an Item'),
          Separator(),
          FormInput(label: 'Item Name'),
          Separator(),
          FormInput(
            inputType: InputType.dropdown,
            items: itemCategories,
            label: 'Item Category',
            hintText: 'Select a Category',
          ),
          // SuccessMessage(message: 'The Item has been create'),
          Separator(),
          _CreateItemFormActionButton(),
          // Loading(),
        ],
      ),
    );
  }
}

class _CreateItemFormActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: 'Back',
            icon: Icons.keyboard_arrow_left,
            contentPosition: Position.center,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
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
