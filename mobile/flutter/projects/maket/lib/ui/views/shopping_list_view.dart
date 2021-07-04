import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/stacked_view.dart';
import 'package:maket/ui/views/set_item_price_view.dart';
import 'package:maket/ui/widgets/add_item_to_shopping_list.dart';
import 'package:maket/ui/widgets/alert_before_delete.dart';
import 'package:maket/ui/widgets/buttons/add_item_to_list_button.dart';
import 'package:maket/ui/widgets/empty_message_alert_view.dart';
import 'package:maket/ui/widgets/floating_container.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/list/list_more_info.dart';
import 'package:maket/ui/widgets/list/list_name.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/on_long_press_actions.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';
import 'package:maket/utils/snackbar/hide_snackbar.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

class ShoppingListView extends StatefulWidget {
  final ShoppingListModel list;

  ShoppingListView({this.list});

  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  ShoppingListViewModel _viewModel = locator<ShoppingListViewModel>();

  bool _isLoading = false;

  bool _hasMissingItems = false;

  Future<dynamic> _showAddItemsToList() async {
    _setState(() => _isLoading = true);

    HttpResponse _response = await _viewModel.getMissingItemsFromList();

    if (!_response.status) {
      _showErrorMessage(message: _response.message);
      return false;
    }

    if (_response.status && !_response.data.isNotEmpty) {
      _showWarningMessage(message: kAllItemsAddedToScreenMessage);
      return false;
    }

    _hideLoading();

    showModal(
      context: context,
      isDismissible: false,
      backgroundColor: kBgPrimaryColor,
      child: Container(
        height: Numbers.size(context: context, percent: Numbers.ninety),
        child: AddItemsToShoppingListView(
          onBackButtonPress: _onCancelAddItems,
          canSubmit: false,
          onItemTap: _keepSelectedMissingItems,
          saveShoppingList: _saveMissingItemsToList,
        ),
      ),
    );
  }

  void _onCancelAddItems() {
    pop(context: context);
    locator<ItemViewModel>().resetSelectedShoppingListItems();
  }

  Future<void> _keepSelectedMissingItems(ItemModel selectedItem) async {
    await locator<ItemViewModel>().keepSelectedShoppingListItems(
      tappedItem: selectedItem,
    );
  }

  Future<void> _saveMissingItemsToList({BuildContext context}) async {
    HttpResponse _response = await _viewModel.saveMissingItemsToShoppingList(
      listId: widget.list.id,
    );

    pop(context: context);

    if (!_response.status) _showErrorMessage(message: _response.message);

    if (_response.status) {
      _showAlert(
        context: context,
        message: _response.message,
        status: Status.success,
      );
    }

    await _checkIfHasMissingItems();
  }

  void _showErrorMessage({String message}) {
    _hideLoading();
    _showAlert(context: context, message: message, status: Status.error);
  }

  void _showWarningMessage({String message}) {
    _hideLoading();
    _showAlert(context: context, message: message, status: Status.warning);
  }

  void _showAlert({BuildContext context, String message, Status status}) {
    showSnackBar(
      context: context,
      flavor: status,
      content: SnackBarAlert(
        message: message,
        textColor: getStatusTextColor(status),
      ),
    );
  }

  void _hideLoading() => _setState(() => _isLoading = false);

  Future<void> _checkIfHasMissingItems() async {
    HttpResponse _response = await _viewModel.getMissingItemsFromList();

    if (_response.status && _response.data.isNotEmpty) {
      _setState(() => _hasMissingItems = true);
    } else {
      _setState(() => _hasMissingItems = false);
    }
  }

  _setState(fn) => super.setState(fn);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      withSafeArea: false,
      child: StackedView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ShoppingListInfoBlock(list: widget.list),
              _ShoppingListItems(
                listId: widget.list.id,
                checkIfHasMissingItems: _checkIfHasMissingItems,
              ),
            ],
          ),
          if (_hasMissingItems)
            AddItemToListButton(
              onTap: () => _showAddItemsToList(),
              isLoading: _isLoading,
            ),
          ChangeNotifierProvider<ShoppingListViewModel>.value(
            value: locator<ShoppingListViewModel>(),
            child: _Spent(budget: widget.list.budget),
          ), // PlusButton(),
        ],
      ),
    );
  }
}

class _ShoppingListInfoBlock extends StatelessWidget {
  final ShoppingListModel list;

  _ShoppingListInfoBlock({this.list});

  bool _hasDescription({String description}) {
    return (description != null && description != '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: PaddingView(
        vertical: Numbers.size(context: context, percent: Numbers.three),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NavBar(color: kTextPrimaryColor),
            ListName(
              name: list.name,
              color: kTextPrimaryColor,
              fontSize: Numbers.size(context: context, percent: Numbers.three),
            ),
            if (_hasDescription(description: list.description))
              Separator(distanceAsPercent: Numbers.five, thin: true),
            if (_hasDescription(description: list.description))
              ListSubTitle(
                text: list.description,
                fontSize: Numbers.size(context: context, percent: Numbers.two) -
                    Numbers.one,
              ),
            Separator(distanceAsPercent: Numbers.five, thin: true),
            _ShoppingListMoreInfo(list: list),
          ],
        ),
      ),
    );
  }
}

class _ShoppingListMoreInfo extends StatelessWidget {
  final ShoppingListModel list;
  _ShoppingListMoreInfo({this.list});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ExpandedView(
          child: ListItemCountAndCreateDate(
            fontSize: Numbers.size(context: context, percent: Numbers.two) -
                Numbers.two,
            list: list,
            showSpent: false,
          ),
        ),
      ],
    );
  }
}

class _Spent extends StatelessWidget {
  final double budget;

  _Spent({this.budget});

  @override
  Widget build(BuildContext context) {
    TextStyle _spentAmountStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: kTextPrimaryColor,
      fontSize: (Numbers.size(context: context, percent: Numbers.two)),
    );
    String _spent = context.watch<ShoppingListViewModel>().getSpent;

    return (_spent != Numbers.minSpent())
        ? FloatingContainer(
            position: Alignment.bottomLeft,
            backgroundColor: (Numbers.stringToDouble(_spent) > budget)
                ? kErrorColor
                : kTextActionColor,
            widthDivideBy: Numbers.two,
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Separator(
                  dimension: Dimension.width,
                  distanceAsPercent: Numbers.one,
                ),
                Text('R$_spent', style: _spentAmountStyle),
              ],
            ),
          )
        : Text('');
  }
}

class _ShoppingListItems extends StatefulWidget {
  final String listId;
  final Function checkIfHasMissingItems;

  _ShoppingListItems({this.listId, this.checkIfHasMissingItems});

  @override
  __ShoppingListItemsState createState() => __ShoppingListItemsState();
}

class __ShoppingListItemsState extends State<_ShoppingListItems> {
  ShoppingListViewModel _viewModel = locator<ShoppingListViewModel>();

  bool _itemSelectionTriggered = false;

  Future<void> _handleItemTap(ItemModel item) async {
    if (!_itemSelectionTriggered) {
      _showSetItemPriceView(item: item);
    } else {
      await _selectItem(item: item);
    }
  }

  void _showSetItemPriceView({ItemModel item}) {
    showModal(
      context: context,
      child: SetItemPriceView(item: item, listId: widget.listId),
    );
  }

  Future<void> _handleItemLongPress(ItemModel item) async {
    if (_itemSelectionTriggered) return false;

    _toggleSelectionState();

    await _selectItem(item: item);

    showSnackBar(
      context: context,
      content: OnLongPressActions(
        onCancel: _handleSelectionCancel,
        selectAllList: _selectAllItems,
        onDelete: _onIconDeleteItemTapped,
      ),
      duration: kOneYearDuration,
    );
  }

  Future<void> _handleSelectionCancel() async {
    _toggleSelectionState();
    await _viewModel.unSelectAllListItems();
    hideSnackBar(context: context);
  }

  Future<void> _selectItem({ItemModel item}) async {
    await _viewModel.selectListItem(item: item);
  }

  Future<void> _selectAllItems() async {
    await _viewModel.selectAllItems();
  }

  void _onIconDeleteItemTapped() {
    showModal(
      context: context,
      child: ModalContainer(
        content: AlertBeforeDelete(
          subTitle: kDeleteItemsWarningText,
          onYesPressed: _deleteSelectedItems,
        ),
      ),
    );
  }

  Future<void> _deleteSelectedItems() async {
    pop(context: context);

    final HttpResponse _response =
        await _viewModel.deleteAllSelectedItems(listId: widget.listId);

    if (_response.status) {
      _showMessage(response: _response, status: Status.success);
      hideSnackBar(context: context);
    }

    if (!_response.status) {
      _showMessage(response: _response, status: Status.error);
    }

    _toggleSelectionState();

    widget.checkIfHasMissingItems();
  }

  void _toggleSelectionState() {
    _setState(() => _itemSelectionTriggered = !_itemSelectionTriggered);
  }

  void _showMessage({HttpResponse response, Status status: Status.success}) {
    _future(() => showSnackBar(
          context: context,
          flavor: status,
          content: SnackBarAlert(message: response.message),
        ));
  }

  void _future(Function callback) {
    Future.delayed(Duration.zero, callback);
  }

  void _setState(Function fn) => super.setState(fn);

  @override
  void initState() {
    _future(() async {
      await _viewModel.getListItems(listId: widget.listId);
      await widget.checkIfHasMissingItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>.value(
      value: _viewModel,
      child: ExpandedView(
        child: Consumer<ShoppingListViewModel>(
          builder: (_, viewModel, loader) {
            if (viewModel.state == ViewState.busy) return loader;

            if (!viewModel.hasItems && viewModel.responseListItems.status) {
              return EmptyMessageAlert(
                title: kTitleTextNoItemsForList,
                subtitle: kSubTitleTextNoItemsForList,
              );
            }

            if (viewModel.state == ViewState.idle &&
                !viewModel.responseListItems.status) {
              _showMessage(response: viewModel.responseListItems);

              return EmptyMessageAlert(
                title: kOnErrorReloadMessage,
                subtitle: kOnErrorReloadSubMessage,
              );
            }

            return ListItems(
              items: viewModel.responseListItems.data,
              onItemTaped: _handleItemTap,
              onItemLongPress: _handleItemLongPress,
            );
          },
          child: Loading(),
        ),
      ),
    );
  }
}
