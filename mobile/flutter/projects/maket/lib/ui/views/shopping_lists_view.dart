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
import 'package:maket/ui/widgets/alert_before_delete.dart';
import 'package:maket/ui/widgets/app_bar.dart';
import 'package:maket/ui/widgets/buttons/create_items.dart';
import 'package:maket/ui/widgets/buttons/create_list.dart';
import 'package:maket/ui/widgets/empty_message_alert_view.dart';
import 'package:maket/ui/widgets/fields/search_input_placeholder.dart';
import 'package:maket/ui/widgets/floating_container.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/on_long_press_actions.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';
import 'package:maket/utils/snackbar/hide_snackbar.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

class ShoppingListsView extends StatefulWidget {
  @override
  _ShoppingListsViewState createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  void _showSearchView() {
    pushRoute(context: context, name: AppRoute.listSearchView);
  }

  @override
  void initState() {
    locator<ShoppingListViewModel>().getAllListBodies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>(
      create: (context) => locator<ShoppingListViewModel>(),
      child: WillPopScope(
        child: Consumer<ShoppingListViewModel>(
          builder: (_, viewModel, child) {
            return BaseView(
              safeAreaBottom: false,
              appBar: (viewModel.response.data.length > Numbers.zero)
                  ? appBar(
                      title: SearchInputPlaceholder(
                      hint: 'Search Lists',
                      onTap: _showSearchView,
                    ))
                  : null,
              child: child,
            );
          },
          child: _ShoppingListsViewBody(),
        ),
        onWillPop: () async => false,
      ),
    );
  }
}

class _ShoppingListsViewBody extends StatelessWidget {
  void _showAlert({HttpResponse response, BuildContext context}) {
    Future.delayed(
      Duration(),
      () => showSnackBar(
        flavor: Status.error,
        context: context,
        content: SnackBarAlert(message: response.message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingListViewModel>(
      builder: (_, viewModel, child) {
        final HttpResponse _response = viewModel.response;

        dynamic _shoppingLists = _response.data;

        final bool _hasLists = _shoppingLists.length > Numbers.zero;

        final bool _isLoading = viewModel.state == ViewState.busy;

        List<Widget> _view = [];

        if (!_response.status && viewModel.state == ViewState.idle) {
          _showAlert(response: _response, context: context);
        } else {
          if (!_isLoading && _hasLists)
            _view.add(_ShoppingListTiles(lists: _shoppingLists));
        }

        if (child != null) _view.add(child);

        if (_isLoading) _view.add(Loading());

        if (!_isLoading && !_hasLists) _view.add(EmptyMessageAlert());

        return Stack(children: _view);
      },
      child: _ButtonsCreateItemsAndLists(),
    );
  }
}

class _ShoppingListTiles extends StatefulWidget {
  final List<ShoppingListModel> lists;

  _ShoppingListTiles({this.lists});

  @override
  __ShoppingListTilesState createState() => __ShoppingListTilesState();
}

class __ShoppingListTilesState extends State<_ShoppingListTiles> {
  bool _longPressTriggered = false;

  ShoppingListViewModel _viewModel = locator<ShoppingListViewModel>();

  void _onListLongPressed({ShoppingListModel list}) {
    _setState(() => _longPressTriggered = true);
    _viewModel.selectShoppingList(list: list);
    _viewModel.countSelectedList();
    _showOnLongPressedSnackAction();
  }

  void _showOnLongPressedSnackAction() {
    showSnackBar(
      context: context,
      content: OnLongPressActions(
        onCancel: _cancelSelection,
        selectAllList: _selectAllShoppingLists,
        onDelete: _showBeforeDeleteWarning,
      ),
      duration: kOneYearDuration,
    );
  }

  void _cancelSelection() {
    _viewModel.unselectAllShoppingLists();
    _setState(() {
      _longPressTriggered = false;
    });
    hideSnackBar(context: context);
  }

  void _selectAllShoppingLists() {
    _viewModel.selectAllShoppingLists();
    _viewModel.countSelectedList();
    _viewModel.setIsAllSelected();
  }

  void _showBeforeDeleteWarning() {
    showModal(
      context: context,
      child: ModalContainer(
        content: AlertBeforeDelete(
          subTitle: kDeleteListWarningText,
          onYesPressed: _deleteSelectedLists,
        ),
      ),
    );
  }

  Future<void> _deleteSelectedLists() async {
    final HttpResponse _res = await _viewModel.deleteSelectedShoppingLists();

    _cancelSelection();

    pop(context: context);

    if (_res.status) {
      showSnackBar(
        context: context,
        flavor: Status.success,
        content: SnackBarAlert(message: _res.message),
      );
    } else {
      showSnackBar(
        context: context,
        flavor: Status.error,
        content: SnackBarAlert(message: _res.message),
      );
    }
  }

  void _onListTapped({ShoppingListModel list}) {
    if (_longPressTriggered) {
      _viewModel.selectShoppingList(list: list);
      _viewModel.countSelectedList();
      _viewModel.setIsAllSelected();
    } else {
      pushRoute(
        context: context,
        name: AppRoute.shoppingListView,
        arguments: list,
      );
    }
  }

  void _setState(Function callback) => super.setState(callback);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        if (index == Numbers.zero) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShoppingListTile(
                list: widget.lists[index],
                onTap: _onListTapped,
                onLongPress: _onListLongPressed,
                longPressTriggered: _longPressTriggered,
              ),
              Separator(distanceAsPercent: Numbers.three),
              if (widget.lists.length > Numbers.one) _HistoryListTitle(),
              Separator(distanceAsPercent: Numbers.one, thin: true),
            ],
          );
        }

        if (index != widget.lists.length) {
          return ShoppingListTile(
            list: widget.lists[index],
            onTap: _onListTapped,
            onLongPress: _onListLongPressed,
            longPressTriggered: _longPressTriggered,
          );
        } else {
          return Separator(distanceAsPercent: Numbers.eight);
        }
      },
      itemCount: widget.lists.length + Numbers.one,
      separatorBuilder: (_, __) => Separator(
        distanceAsPercent: Numbers.one,
        thin: true,
      ),
    );
  }
}

class _ButtonsCreateItemsAndLists extends StatelessWidget {
  Future<void> _showCreateItemsModal({BuildContext context}) async {
    // await LocalStorage.remove(key: HttpHeadersKeys.xToken);

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
    final TextStyle _style = TextStyle(
      fontSize: Numbers.size(context: context, percent: Numbers.two),
      color: kTextSecondaryColor,
      fontWeight: FontWeight.w800,
      letterSpacing: kLetterSpacing,
    );
    return PaddingView(child: Text('History', style: _style));
  }
}
