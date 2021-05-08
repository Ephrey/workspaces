import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/plus_button_view.dart';
import 'package:maket/ui/widgets/empty_shopping_list_view.dart';
import 'package:maket/ui/widgets/list_tile.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ShoppingListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(child: _ShoppingListsViewBody());
  }
}

class _ShoppingListsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _hasList = true;
    return Stack(
      children: [
        if (!_hasList) EmptyShopListsView(),
        if (_hasList) _ShoppingListTiles(),
        if (_hasList) SearchView(),
        PlusButton(),
      ],
    );
  }
}

class _ShoppingListTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Separator(
          distanceAsPercent: Numbers.seven,
        ),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
      ],
    );
  }
}
