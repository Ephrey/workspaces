import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/widgets/buttons/plus_button_view.dart';
import 'package:maket/ui/widgets/empty_shopping_list_view.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/numbers.dart';

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
    bool _hasList = true;
    bool _isSelecting = true;
    return Stack(
      children: [
        if (!_hasList) EmptyShopListsView(),
        if (_hasList) _ShoppingListTiles(),
        if (_hasList) SearchView(),
        if (!_isSelecting) PlusButton(),
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
