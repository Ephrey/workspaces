import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/widgets/app_bar.dart';
import 'package:maket/ui/widgets/back_arrow.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:provider/provider.dart';

class ItemsSearchView extends StatelessWidget {
  Future<void> _onUserType(dynamic searchValue) async {
    await locator<ItemViewModel>().searchItemByName(name: searchValue);
  }

  void _clearSearch() {
    final ItemViewModel _itemViewModel = locator<ItemViewModel>();
    _itemViewModel.setIsNotSearching();
    _itemViewModel.clearSearchedResults(notify: true);
  }

  AppBar _getAppBar() {
    return appBar(
      title: _SearchInput(onChange: _onUserType, clearSearch: _clearSearch),
      leadingIcon: _BackIcon(clearSearch: _clearSearch),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemViewModel>.value(
      value: locator<ItemViewModel>(),
      child: BaseView(appBar: _getAppBar(), child: _SearchViewBody()),
    );
  }
}

class _BackIcon extends StatelessWidget {
  final Function clearSearch;

  _BackIcon({this.clearSearch});

  void _onBackArrowClick({BuildContext context}) {
    clearSearch();
    pop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: BackArrow(),
      onTap: () => _onBackArrowClick(context: context),
    );
  }
}

class _SearchInput extends StatefulWidget {
  final Function onChange;
  final Function clearSearch;

  _SearchInput({this.onChange, this.clearSearch});

  @override
  __SearchInputState createState() => __SearchInputState();
}

class __SearchInputState extends State<_SearchInput> {
  TextEditingController _controller;

  void _clearSearchInput() {
    setState(() => super.setState(() => _controller.clear()));
    widget.clearSearch();
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormInput(
      controller: _controller,
      hintText: 'Search for Items',
      suffixIcon: context.watch<ItemViewModel>().checkIfSearching
          ? _ClearSearchIcon(clearSearchInput: _clearSearchInput)
          : Text(''),
      textAlign: TextAlign.center,
      autoFocus: true,
      onChange: widget.onChange,
    );
  }
}

class _ClearSearchIcon extends StatelessWidget {
  final Function clearSearchInput;

  _ClearSearchIcon({this.clearSearchInput});

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Icon(Icons.close_sharp, color: kTextSecondaryColor),
      onTap: clearSearchInput,
    );
  }
}

class _SearchViewBody extends StatelessWidget {
  Future<void> _selectItem(ItemModel item) async {
    await locator<ItemViewModel>()
        .keepSelectedShoppingListItems(tappedItem: item);
  }

  @override
  Widget build(BuildContext context) {
    dynamic _watcher = context.watch<ItemViewModel>();

    if (_watcher.state == ViewState.busy) {
      return Loading();
    }

    if (!_watcher.hasSearchedResults) {
      return _TipsText();
    }

    return ListItems(
      items: _watcher.getSearchedItems,
      onItemTaped: _selectItem,
    );
  }
}

class _TipsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _style = TextStyle(
      fontSize: 15.0,
      color: kTextSecondaryColor,
      letterSpacing: kLetterSpacing,
    );

    return Column(
      children: [
        Separator(),
        CenteredView(child: Text(kResultWillPearHereText, style: _style)),
      ],
    );
  }
}
