import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/stacked_view.dart';
import 'package:maket/ui/views/set_item_price_view.dart';
import 'package:maket/ui/widgets/buttons/add_item_to_list_button.dart';
import 'package:maket/ui/widgets/empty_message_alert_view.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/list/list_more_info.dart';
import 'package:maket/ui/widgets/list/list_name.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/on_long_press_actions.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';
import 'package:maket/utils/snackbar/hide_snackbar.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

class ShoppingListView extends StatelessWidget {
  final ShoppingListModel list;

  ShoppingListView({this.list});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      withSafeArea: false,
      child: StackedView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ShoppingListInfoBlock(list: list),
              _ShoppingListItems(listId: list.id),
              // Separator(distanceAsPercent: Numbers.ten),
            ],
          ),
          AddItemToListButton(), // PlusButton(),
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
              fontSize: (Numbers.size(context: context, percent: Numbers.four) -
                  Numbers.two),
            ),
            if (_hasDescription(description: list.description))
              Separator(distanceAsPercent: Numbers.two),
            if (_hasDescription(description: list.description))
              ListSubTitle(
                text: list.description,
                fontSize: Numbers.size(context: context, percent: Numbers.two) -
                    Numbers.three,
              ),
            Separator(distanceAsPercent: Numbers.two),
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
                Numbers.four,
            list: list,
          ),
        ),
        ChangeNotifierProvider<ShoppingListViewModel>.value(
          value: locator<ShoppingListViewModel>(),
          child: _Spent(spent: 0.0),
        ),
      ],
    );
  }
}

class _Spent extends StatelessWidget {
  final double spent;

  _Spent({this.spent});

  @override
  Widget build(BuildContext context) {
    TextStyle _spentAmountStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: kBgPrimaryColor,
      fontSize:
          (Numbers.size(context: context, percent: Numbers.two) - Numbers.two),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const Text('spt.', style: TextStyle(color: kTextSecondaryColor)),
        Separator(
          dimension: Dimension.width,
          distanceAsPercent: Numbers.one,
        ),
        Text('R${context.watch<ShoppingListViewModel>().getSpent}',
            style: _spentAmountStyle),
      ],
    );
  }
}

class _ShoppingListItems extends StatefulWidget {
  final String listId;

  _ShoppingListItems({this.listId});

  @override
  __ShoppingListItemsState createState() => __ShoppingListItemsState();
}

class __ShoppingListItemsState extends State<_ShoppingListItems> {
  void _handleItemTap(ItemModel item) {
    showModal(context: context, child: SetItemPriceView(item: item));
  }

  void _handleItemLongPress(ItemModel item) {
    showSnackBar(
      context: context,
      content: OnLongPressActions(
        onCancel: () => hideSnackBar(context: context),
      ),
      duration: kOneYearDuration,
    );
  }

  void _shoErrorMessage({HttpResponse response}) {
    _future(() => showSnackBar(
          context: context,
          flavor: Status.error,
          content: SnackBarAlert(message: response.message),
        ));
  }

  @override
  void initState() {
    _future(() => locator<ShoppingListViewModel>().getListItems(
          listId: widget.listId,
        ));
    super.initState();
  }

  void _future(Function callback) {
    Future.delayed(Duration.zero, callback);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>.value(
      value: locator<ShoppingListViewModel>(),
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
              _shoErrorMessage(response: viewModel.responseListItems);

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
