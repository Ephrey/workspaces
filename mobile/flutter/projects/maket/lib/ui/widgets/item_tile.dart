import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ItemTitle extends StatelessWidget {
  final dynamic item;
  final Function onItemTap;
  final Function onItemLongPress;

  const ItemTitle({
    @required this.item,
    this.onItemTap,
    this.onItemLongPress,
  }) : assert(item != null);

  Icon _getLeadingIcon(isSelected, isItemsTitle) {
    return (isSelected)
        ? (!isItemsTitle)
            ? Icon(Icons.check_box, color: kPrimaryColor)
            : null
        : (!isItemsTitle)
            ? (!isSelected)
                ? null
                : Icon(Icons.check_box_outline_blank,
                    color: kTextSecondaryColor)
            : null;
  }

  @override
  Widget build(BuildContext context) {
    print(Numbers.size(context: context, percent: Numbers.two) - Numbers.four);
    double _screenTwoPercent =
        Numbers.size(context: context, percent: Numbers.two);

    bool _isItemsTitle = item['type'] != null;

    double _horizontalPadding = (!_isItemsTitle)
        ? (Numbers.size(context: context, percent: Numbers.three) -
            Numbers.three)
        : (_screenTwoPercent - Numbers.four);

    TextStyle _itemNameStyle = TextStyle(
      color: (!_isItemsTitle) ? kPrimaryColor : kTextSecondaryColor,
      fontSize: (_screenTwoPercent - Numbers.two),
      fontWeight: (!_isItemsTitle) ? FontWeight.w400 : FontWeight.w700,
    );

    bool _isSelected = (item['id'] == "6") ? false : true;

    return ListTile(
      leading: _getLeadingIcon(_isSelected, _isItemsTitle),
      tileColor: (!_isItemsTitle)
          ? (_isSelected)
              ? kBgPrimaryColor
              : kSecondaryColor
          : null,
      contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      title: Text('${item['name']}', style: _itemNameStyle),
      onTap: _isItemsTitle
          ? null
          : (_isSelected)
              ? null
              : () => onItemTap(item),
      onLongPress: _isItemsTitle ? null : () => onItemLongPress(item),
      trailing: (!_isItemsTitle && _isSelected)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'R1.003,99',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize:
                        (Numbers.size(context: context, percent: Numbers.two) -
                            Numbers.four),
                    letterSpacing: 0.5,
                  ),
                ),
                Separator(dimension: Dimension.width),
                Icon(Icons.check, color: kPrimaryColor),
              ],
            )
          : null,
    );
  }
}
