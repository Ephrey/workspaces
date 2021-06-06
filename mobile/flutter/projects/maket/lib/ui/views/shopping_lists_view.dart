import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/create_item_view.dart';
import 'package:maket/ui/widgets/buttons/create_items.dart';
import 'package:maket/ui/widgets/buttons/create_list.dart';
import 'package:maket/ui/widgets/floating_container.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';

class ShoppingListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BaseView(safeAreaBottom: false, child: _ShoppingListsViewBody()),
      onWillPop: () async => false,
    );
  }
}

class _ShoppingListsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // EmptyShopListsView(),
        _ShoppingListTiles(),
        SearchView(),
        FloatingContainer(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CreateItemsButton(
                onTap: () => showModel(
                  context: context,
                  child: CreateItemView(),
                  isScrollControlled: true,
                  isDismissible: false,
                ),
              ),
              CreateListButton(
                onTap: () => pushRoute(
                  context: context,
                  name: AppRoute.createShoppingList,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShoppingListTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return ShoppingListTile();
      },
      itemCount: Numbers.twentyFive,
    );
  }
}

/*
PaddingView(
            child: Text(
          'History',
          style: TextStyle(
            fontSize: 20.0,
            color: kTextSecondaryColor,
            fontWeight: FontWeight.w800,
            letterSpacing: kLetterSpacing,
          ),
        )),
 */
