import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/widgets/buttons/plus_button_view.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';

import 'create_shopping_list_and_item_view.dart';

class ShoppingListsView extends StatefulWidget {
  @override
  _ShoppingListsViewState createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  void _fetchList() async {
    print('token from LS : Shopping Lists view');
    print(await LocalStorage.get(HttpHeadersKeys.xToken));
    print('token from LS : Shopping Lists view');
  }

  @override
  void initState() {
    _fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(child: _ShoppingListsViewBody());
  }
}

class _ShoppingListsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // bool _hasList = false;
    // bool _isSelecting = false;
    return Stack(
      children: [
        // EmptyShopListsView(),
        _ShoppingListTiles(),
        SearchView(),
        PlusButton(
          onTap: () => showModel(
            context: context,
            child: CreateShoppingListAndItemView(),
          ),
        ),
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
