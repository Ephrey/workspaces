import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';
import 'package:provider/provider.dart';

import 'fields/search_input_placeholder.dart';

class AddItemsToShoppingListView extends StatefulWidget {
  final Function onBackButtonPress;
  final List<ItemModel> items;
  final Function onItemTap;
  final bool canSubmit;
  final Function saveShoppingList;

  AddItemsToShoppingListView({
    this.onBackButtonPress,
    this.items,
    this.onItemTap,
    this.canSubmit,
    this.saveShoppingList,
  });

  @override
  _AddItemsToShoppingListViewState createState() =>
      _AddItemsToShoppingListViewState();
}

class _AddItemsToShoppingListViewState
    extends State<AddItemsToShoppingListView> {
  List<ItemModel> _items;
  int _selectedItems = 0;

  bool _localState = true;

  bool _canSubmit = false;

  void _onItemTapped(ItemModel tapedItem) {
    if (_canSubmit && !_localState) {
      widget.onItemTap(tapedItem);
    } else {
      _checkSelectedItems(tapedItem);
    }
  }

  void _checkSelectedItems(ItemModel tapedItem) {
    setState(() {
      _items.forEach((ItemModel item) {
        if (item.id == tapedItem.id) {
          item.selected = !item.selected;
          widget.onItemTap(item);
          (item.selected) ? _selectedItems++ : _selectedItems--;
          _checkIfCanSubmit();
        }
      });
    });
  }

  void _checkIfCanSubmit() {
    setState(() {
      _canSubmit = (_selectedItems > Numbers.zero);
    });
  }

  @override
  void initState() {
    _items = widget.items;
    if (widget.canSubmit) {
      _canSubmit = widget.canSubmit;
      _localState = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchInputPlaceholder(hint: 'Search Items'),
        Separator(distanceAsPercent: Numbers.two),
        _ItemsList(items: _items, onItemTap: _onItemTapped),
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
            buttonType: (canSubmit) ? ButtonType.primary : ButtonType.disable,
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
