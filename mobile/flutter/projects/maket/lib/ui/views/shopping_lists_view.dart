import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/create_item_view.dart';
import 'package:maket/ui/widgets/buttons/create_items.dart';
import 'package:maket/ui/widgets/buttons/create_list.dart';
import 'package:maket/ui/widgets/empty_shopping_list_view.dart';
import 'package:maket/ui/widgets/floating_container.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';
import 'package:provider/provider.dart';

class ShoppingListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BaseView(safeAreaBottom: false, child: _ShoppingListsViewBody()),
      onWillPop: () async => false,
    );
  }
}

class _ShoppingListsViewBody extends StatefulWidget {
  @override
  __ShoppingListsViewBodyState createState() => __ShoppingListsViewBodyState();
}

class __ShoppingListsViewBodyState extends State<_ShoppingListsViewBody> {
  @override
  void initState() {
    locator<ShoppingListViewModel>().getAllListBodies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>(
      create: (context) => locator<ShoppingListViewModel>(),
      child: Consumer<ShoppingListViewModel>(
        builder: (context, viewModel, child) {
          dynamic _shoppingLists = viewModel.response.data;

          print('*** ${_shoppingLists.length} ***');
          final _hasLists = _shoppingLists.length > Numbers.zero;
          final _isLoading = viewModel.state == ViewState.busy;

          List<Widget> _view = [
            if (!_isLoading && _hasLists)
              _ShoppingListTiles(lists: _shoppingLists),
            if (_hasLists) SearchView(),
            if (child != null) child,
          ];

          if (_isLoading) _view.add(Loading());

          if (!_isLoading && !_hasLists) _view.add(EmptyShopListsView());

          return Stack(children: _view);
        },
        child: _ButtonsCreateItemsAndLists(),
      ),
    );
  }
}

class _ShoppingListTiles extends StatelessWidget {
  final List<dynamic> lists;

  _ShoppingListTiles({this.lists});

  @override
  Widget build(BuildContext context) {
    List<ShoppingListModel> _lists =
        ShoppingListModel.shoppingListBodiesFromJson(
      jsonShoppingListBodies: lists,
    );

    return ListView.separated(
      itemBuilder: (_, index) {
        if (index == Numbers.zero) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Separator(distanceAsPercent: Numbers.seven),
              ShoppingListTile(list: _lists[index]),
              Separator(),
              _HistoryListTitle(),
              Separator(distanceAsPercent: Numbers.two),
            ],
          );
        }

        if (index != _lists.length) {
          return ShoppingListTile(list: _lists[index]);
        } else {
          return Separator(distanceAsPercent: Numbers.eight);
        }
      },
      itemCount: _lists.length + Numbers.one,
      separatorBuilder: (_, __) => Separator(
        distanceAsPercent: Numbers.one,
        thin: true,
      ),
    );
  }
}

class _ButtonsCreateItemsAndLists extends StatelessWidget {
  void _showCreateItemsModal({BuildContext context}) {
    showModal(
      context: context,
      child: CreateItemView(),
      isScrollControlled: true,
      isDismissible: false,
    );
  }

  void _navigateToCreateListView({BuildContext context}) {
    pushRoute(context: context, name: AppRoute.createShoppingList);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingContainer(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CreateItemsButton(
            onTap: () => _showCreateItemsModal(context: context),
          ),
          CreateListButton(
            onTap: () => _navigateToCreateListView(context: context),
          ),
        ],
      ),
    );
  }
}

class _HistoryListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingView(
      child: Text(
        'History',
        style: TextStyle(
          fontSize: 20.0,
          color: kTextSecondaryColor,
          fontWeight: FontWeight.w800,
          letterSpacing: kLetterSpacing,
        ),
      ),
    );
  }
}
