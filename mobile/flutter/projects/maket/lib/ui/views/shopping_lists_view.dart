import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/plus_button_view.dart';
import 'package:maket/ui/widgets/empty_shopping_list_view.dart';

class ShoppingListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(child: _ShoppingListsViewBody());
  }
}

class _ShoppingListsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingView(
      child: Stack(
        children: [
          PlusButton(),
          EmptyShopListsView(),
        ],
      ),
    );
  }
}
