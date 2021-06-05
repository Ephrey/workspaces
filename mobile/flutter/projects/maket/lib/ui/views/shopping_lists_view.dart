import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/create_item_view.dart';
import 'package:maket/ui/widgets/buttons/create_items.dart';
import 'package:maket/ui/widgets/buttons/create_list.dart';
import 'package:maket/ui/widgets/floating_container.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';

class ShoppingListsView extends StatefulWidget {
  @override
  _ShoppingListsViewState createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  void _fetchList() async {
    final HttpResponse _response =
        await locator<ShoppingListViewModel>().getAll();
    if (_response.status) {
      print(_response.data);
    } else {
      print(_response.message);
    }
  }

  @override
  void initState() {
    _fetchList();
    super.initState();
  }

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
    // bool _hasList = false;
    // bool _isSelecting = false;
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
    return ListView(
      children: [
        Separator(distanceAsPercent: Numbers.seven),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.three),
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
        Separator(distanceAsPercent: Numbers.three),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.one),
        ShoppingListTile(),
        Separator(distanceAsPercent: Numbers.ten),
      ],
    );
  }
}
