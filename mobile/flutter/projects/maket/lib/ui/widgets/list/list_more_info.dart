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

  ListItemCountAndCreateDate({
    this.fontSize,
    this.list,
    this.showSpent: true,
    this.itemsCounter,
  });

  @override
  Widget build(BuildContext context) {
    dynamic _separator = Separator(
      distanceAsPercent: Numbers.two,
      dimension: Dimension.width,
    );

    bool _hasBudget = (list.budget > Numbers.asDouble(Numbers.zero));
    bool _hasSpent = (list.spent > Numbers.asDouble(Numbers.zero));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChangeNotifierProvider<ShoppingListViewModel>.value(
          value: locator<ShoppingListViewModel>(),
          child: _ItemCounter(list: list, fontSize: fontSize),
        ),
        _separator,
        DotSeparator(),
        _separator,
        if (_hasBudget)
          ListSubTitle(
            text: 'R${list.budget}',
            fontWeight: FontWeight.w700,
            fontSize: (fontSize),
          ),
        if (_hasBudget) _separator,
        if (_hasBudget) DotSeparator(),
        if (_hasBudget) _separator,
        if (_hasSpent && showSpent)
          ListSubTitle(
            text: 'R${list.spent.toStringAsFixed(2)}',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        if (_hasSpent && showSpent) _separator,
        if (_hasSpent && showSpent) DotSeparator(),
        if (_hasSpent && showSpent) _separator,
        ListSubTitle(
          text: locator<Date>().humanReadable(date: list.createDate),
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ],
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
