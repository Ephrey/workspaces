import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/create_item_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/show_modal.dart';

class CreateShoppingListAndItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelContainer(
      content: _CreateShoppingListAndItemButtons(),
    );
  }
}

class _CreateShoppingListAndItemButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ActionButton(
          buttonType: ButtonType.primary,
          text: 'Create a List',
          contentPosition: Position.center,
          onPressed: () => pushRoute(
            context: context,
            name: AppRoute.createShoppingList,
          ),
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
            isDismissible: false,
          ),
        ),
      ],
    );
  }
}
