import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/widgets/app_bar.dart';
import 'package:maket/ui/widgets/back_arrow.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/list/list_tile.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:provider/provider.dart';

class ListSearchView extends StatelessWidget {
  Future<void> _onUserType(dynamic searchValue) async {
    await locator<ShoppingListViewModel>().searchListByName(name: searchValue);
  }

  void _clearSearch() {
    final _watcher = locator<ShoppingListViewModel>();
    _watcher.setIsNotSearching();
    _watcher.clearSearchedResults(notify: true);
  }

  AppBar _getAppBar() {
    return appBar(
      title: _SearchInput(onChange: _onUserType, clearSearch: _clearSearch),
      leadingIcon: _BackIcon(clearSearch: _clearSearch),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>.value(
      value: locator<ShoppingListViewModel>(),
      child: BaseView(appBar: _getAppBar(), child: SearchViewBody()),
    );
  }
}

class _BackIcon extends StatelessWidget {
  final Function clearSearch;

  _BackIcon({this.clearSearch});

  void _onBackArrowTap({BuildContext context}) {
    clearSearch();
    pop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: BackArrow(),
      onTap: () => _onBackArrowTap(context: context),
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
      hintText: 'Search for a List',
      suffixIcon: context.watch<ShoppingListViewModel>().checkIfSearching
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

class SearchViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _watcher = context.watch<ShoppingListViewModel>();

    if (_watcher.state == ViewState.busy) {
      return Loading();
    }

    if (!_watcher.hasSearchedResults) {
      return _TipsText();
    }

    return ListView.separated(
      itemBuilder: (_, index) {
        return ShoppingListTile(
          list: _watcher.getSearchedItems[index],
          onTap: ({ShoppingListModel list}) {
            pushRoute(
              context: context,
              name: AppRoute.shoppingListView,
              arguments: list,
            );
          },
        );
      },
      separatorBuilder: (_, __) => Separator(thin: true),
      itemCount: _watcher.getSearchedItems.length,
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
