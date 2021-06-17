import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/ui/widgets/dot_separator.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/date.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';

class ListItemCountAndCreateDate extends StatelessWidget {
  final double fontSize;
  final ShoppingListModel list;

  ListItemCountAndCreateDate({this.fontSize, this.list});

  @override
  Widget build(BuildContext context) {
    dynamic _separator = Separator(
      distanceAsPercent: Numbers.two,
      dimension: Dimension.width,
    );

    String _plural = (list.itemsCount > Numbers.one) ? 's' : '';

    bool _hasBudget = (list.budget > Numbers.zero);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListSubTitle(
          text: '${list.itemsCount} item$_plural',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        _separator,
        DotSeparator(),
        _separator,
        if (_hasBudget)
          ListSubTitle(
            text: 'R${list.budget}',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        if (_hasBudget) _separator,
        if (_hasBudget) DotSeparator(),
        if (_hasBudget) _separator,
        ListSubTitle(
          text: locator<Date>().humanReadable(date: list.createDate),
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ],
    );
  }
}
