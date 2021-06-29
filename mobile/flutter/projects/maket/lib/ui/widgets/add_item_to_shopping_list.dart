import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:provider/provider.dart';

import 'fields/search_input_placeholder.dart';

class AddItemsToShoppingListView extends StatelessWidget {
  final Function onBackButtonPress;
  final Function onItemTap;
  final bool canSubmit;
  final Function saveShoppingList;

  AddItemsToShoppingListView({
    this.onBackButtonPress,
    this.onItemTap,
    this.canSubmit,
    this.saveShoppingList,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemViewModel>.value(
      value: locator<ItemViewModel>(),
      child: _AddItemsToShoppingListView(
        onBackButtonPress: onBackButtonPress,
        onItemTap: onItemTap,
        canSubmit: canSubmit,
        saveShoppingList: saveShoppingList,
      ),
    );
  }
}

class _AddItemsToShoppingListView extends StatefulWidget {
  final Function onBackButtonPress;
  final Function onItemTap;
  final bool canSubmit;
  final Function saveShoppingList;

  _AddItemsToShoppingListView({
    this.onBackButtonPress,
    this.onItemTap,
    this.canSubmit,
    this.saveShoppingList,
  });
  @override
  __AddItemsToShoppingListViewState createState() =>
      __AddItemsToShoppingListViewState();
}

class __AddItemsToShoppingListViewState
    extends State<_AddItemsToShoppingListView> {
  bool _canSubmit = false;

  void _onItemTapped(ItemModel tapedItem) => widget.onItemTap(tapedItem);

  void _showSearchView() {
    pushRoute(context: context, name: AppRoute.itemsSearchView);
  }

  @override
  void initState() {
    if (widget.canSubmit) _canSubmit = widget.canSubmit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchInputPlaceholder(hint: 'Search Items', onTap: _showSearchView),
        _ItemsList(
          items: context.watch<ItemViewModel>().response.data,
          onItemTap: _onItemTapped,
        ),
        Separator(distanceAsPercent: Numbers.three, thin: true),
        ChangeNotifierProvider<ShoppingListViewModel>.value(
          value: locator<ShoppingListViewModel>(),
          child: PaddingView(
            child: _AddItemsToListActionButton(
              onBackButtonPress: widget.onBackButtonPress,
              canSubmit: _canSubmit,
              saveShoppingList: widget.saveShoppingList,
            ),
          ),
        ),
        Separator(distanceAsPercent: Numbers.two),
      ],
    );
  }
}

class _ItemsList extends StatelessWidget {
  final List<ItemModel> items;
  final Function onItemTap;

  _ItemsList({this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      child: ListItems(
        items: items,
        onItemTaped: onItemTap,
        bottomPadding: false,
      ),
    );
  }
}

class _AddItemsToListActionButton extends StatelessWidget {
  final Function onBackButtonPress;
  final bool canSubmit;
  final Function saveShoppingList;

  _AddItemsToListActionButton({
    this.onBackButtonPress,
    this.canSubmit,
    this.saveShoppingList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: "Back",
            icon: Icons.keyboard_arrow_left,
            contentPosition: Position.center,
            onPressed: onBackButtonPress,
            disabled:
                context.watch<ShoppingListViewModel>().state == ViewState.busy,
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: (canSubmit ||
                    context.watch<ItemViewModel>().hasSelectedShoppingListItems)
                ? ButtonType.primary
                : ButtonType.disable,
            text: "Done",
            contentPosition: Position.center,
            onPressed: () => saveShoppingList(context: context),
            loading:
                context.watch<ShoppingListViewModel>().state == ViewState.busy,
            disabled:
                context.watch<ShoppingListViewModel>().state == ViewState.busy,
          ),
        ),
      ],
    );
  }
}
