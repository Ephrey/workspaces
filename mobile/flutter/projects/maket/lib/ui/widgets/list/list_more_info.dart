import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/widgets/dot_separator.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/date.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';
import 'package:provider/provider.dart';

class ListItemCountAndCreateDate extends StatelessWidget {
  final double fontSize;
  final ShoppingListModel list;
  final bool showSpent;
  final dynamic itemsCounter;
  final longPressTriggered;

  ListItemCountAndCreateDate({
    this.fontSize,
    this.list,
    this.showSpent: true,
    this.itemsCounter,
    this.longPressTriggered: false,
  });

  @override
  Widget build(BuildContext context) {
    dynamic _separator = Separator(
      distanceAsPercent: Numbers.two,
      dimension: Dimension.width,
    );

    bool _hasBudget = (list.budget > Numbers.asDouble(Numbers.zero));

    List<Widget> _children = [
      ChangeNotifierProvider<ShoppingListViewModel>.value(
        value: locator<ShoppingListViewModel>(),
        child: _ItemCounter(list: list, fontSize: fontSize),
      ),
      _separator,
      DotSeparator(),
      _separator,
      if (_hasBudget && !longPressTriggered)
        ListSubTitle(
          text: 'R${list.budget}',
          fontWeight: FontWeight.w700,
          fontSize: (fontSize),
        ),
      if (_hasBudget && !longPressTriggered) _separator,
      if (_hasBudget && !longPressTriggered) DotSeparator(),
      if (_hasBudget && !longPressTriggered) _separator,
    ];

    if (showSpent) {
      _children.add(ChangeNotifierProvider<ShoppingListViewModel>.value(
        value: locator<ShoppingListViewModel>(),
        child: _Spent(list: list, fontSize: fontSize),
      ));
    }

    _children.add(ListSubTitle(
      text: locator<Date>().humanReadable(date: list.createDate),
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
    ));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _children,
    );
  }
}

class _ItemCounter extends StatelessWidget {
  final ShoppingListModel list;
  final double fontSize;

  const _ItemCounter({this.list, this.fontSize});

  @override
  Widget build(BuildContext context) {
    int _itemsCounter =
        context.watch<ShoppingListViewModel>().listItemsCount[list.id];

    if (_itemsCounter == null) _itemsCounter = list.itemsCount;

    String _plural = (_itemsCounter > Numbers.one) ? 's' : '';

    return ListSubTitle(
      text: '$_itemsCounter item$_plural',
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
    );
  }
}

class _Spent extends StatelessWidget {
  final ShoppingListModel list;
  final double fontSize;

  _Spent({this.list, this.fontSize});

  @override
  Widget build(BuildContext context) {
    dynamic _separator = Separator(
      distanceAsPercent: Numbers.two,
      dimension: Dimension.width,
    );

    String _spent = context.watch<ShoppingListViewModel>().getSpent;

    _spent = (_spent != Numbers.minSpent())
        ? _spent
        : Numbers.stringAsFixed(number: list.spent);

    final bool _hasSpent = (_spent != null && _spent != Numbers.minSpent());

    return Row(
      children: [
        if (_hasSpent)
          ListSubTitle(
            text: 'R${list.spent.toStringAsFixed(2)}',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        if (_hasSpent) _separator,
        if (_hasSpent) DotSeparator(),
        if (_hasSpent) _separator,
      ],
    );
  }
}
