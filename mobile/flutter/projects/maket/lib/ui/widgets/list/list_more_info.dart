import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/ui/widgets/dot_separator.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ListItemCountAndCreateDate extends StatelessWidget {
  final double fontSize;
  final ShoppingListModel list;

  ListItemCountAndCreateDate({this.fontSize, this.list});

  String _isPlural() {
    return (list.itemsCount > Numbers.one ? 's' : '');
  }

  @override
  Widget build(BuildContext context) {
    dynamic _separator = Separator(
      distanceAsPercent: Numbers.two,
      dimension: Dimension.width,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListSubTitle(
          text: '${list.itemsCount} item${_isPlural()}',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        _separator,
        DotSeparator(),
        _separator,
        ListSubTitle(
          text: '2020-01-26',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ],
    );
  }
}
