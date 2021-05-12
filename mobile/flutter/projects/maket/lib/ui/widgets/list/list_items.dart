import 'package:flutter/material.dart';
import 'package:maket/ui/widgets/item_tile.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ListItems extends StatelessWidget {
  final items;
  final Function onItemTaped;
  final Function onItemLongPress;
  final double yPadding;
  final double xPadding;

  const ListItems({
    @required this.items,
    @required this.onItemTaped,
    this.onItemLongPress,
    this.yPadding: 0.0,
    this.xPadding: 0.0,
  }) : assert(items != null);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: yPadding, horizontal: xPadding),
      addAutomaticKeepAlives: false,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int itemIndex) {
        return ItemTitle(
          item: items[itemIndex],
          onItemTap: onItemTaped,
          onItemLongPress: onItemLongPress,
        );
      },
      separatorBuilder: (_, __) => Separator(distanceAsPercent: Numbers.one),
    );
  }
}
