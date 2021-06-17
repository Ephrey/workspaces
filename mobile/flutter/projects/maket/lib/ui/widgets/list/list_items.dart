import 'package:flutter/material.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/ui/widgets/item_tile.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ListItems extends StatelessWidget {
  final List<ItemModel> items;
  final Function onItemTaped;
  final Function onItemLongPress;
  final double yPadding;
  final double xPadding;
  final bool bottomPadding;

  const ListItems(
      {@required this.items,
      @required this.onItemTaped,
      this.onItemLongPress,
      this.yPadding: 0.0,
      this.xPadding: 0.0,
      this.bottomPadding: true})
      : assert(items != null);

  @override
  Widget build(BuildContext context) {
    final int _itemsSize = items.length;
    final int _itemCount =
        _itemsSize + ((bottomPadding) ? Numbers.one : Numbers.zero);

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: yPadding, horizontal: xPadding),
      addAutomaticKeepAlives: false,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int itemIndex) {
        if (_itemsSize == itemIndex && bottomPadding) {
          return Separator(distanceAsPercent: Numbers.eleven);
        }

        return ItemTitle(
          item: items[itemIndex],
          itemIndex: itemIndex,
          onItemTap: onItemTaped,
          onItemLongPress: onItemLongPress,
        );
      },
      separatorBuilder: (_, __) => Separator(
        distanceAsPercent: Numbers.one,
        thin: true,
      ),
    );
  }
}
