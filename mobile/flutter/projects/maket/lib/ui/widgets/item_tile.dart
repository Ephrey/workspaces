import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ItemTitle extends StatelessWidget {
  final ItemModel item;
  final Function onItemTap;
  final Function onItemLongPress;
  final bool isLongPress;

  const ItemTitle({
    @required this.item,
    this.onItemTap,
    this.onItemLongPress,
    this.isLongPress: false,
  }) : assert(item != null);

  Icon _getCheckBoxIcon({bool isSelected, bool isItemsTitle}) {
    if (isSelected) {
      return (!isItemsTitle)
          ? Icon(Icons.check_box, color: kPrimaryColor)
          : null;
    } else {
      return null;
    }
  }

  double _getTileHorizontalPadding({
    BuildContext context,
    bool isSelected,
    bool isItemTitle,
    double screenHeightTwoPercent,
  }) {
    if (isItemTitle) {
      return (screenHeightTwoPercent - Numbers.four);
    } else {
      return (Numbers.size(context: context, percent: Numbers.three) -
          Numbers.three);
    }
  }

  Color _getTileBackgroundColor({bool isSelected, bool isItemTitle}) {
    if (isItemTitle) return null;
    return (isSelected) ? kBgPrimaryColor : kSecondaryColor;
  }

  double _getItemPrice({ItemModel item}) {
    if (item.price == null) return Numbers.asDouble(Numbers.zero);
    return (item.price);
  }

  Function _toggleOnTapEvent({
    bool isSelected,
    bool isItemTitle,
    Function callback,
  }) {
    if (isItemTitle) return null;
    return callback;
  }

  @override
  Widget build(BuildContext context) {
    bool _isSelected = item.selected != null ? item.selected : false;

    double _screenHeightTwoPercent =
        Numbers.size(context: context, percent: Numbers.two);

    bool _isItemsTitle = (item.category == ItemConstants.itemGroupTitle);

    double _horizontalPadding = _getTileHorizontalPadding(
      context: context,
      isSelected: _isSelected,
      isItemTitle: _isItemsTitle,
      screenHeightTwoPercent: _screenHeightTwoPercent,
    );

    TextStyle _itemNameStyle = TextStyle(
      color: (!_isItemsTitle)
          ? (_isSelected)
              ? kTextSecondaryColor
              : kPrimaryColor
          : kTextSecondaryColor,
      fontSize: (_screenHeightTwoPercent - Numbers.two),
      fontWeight: (!_isItemsTitle) ? FontWeight.w400 : FontWeight.w700,
      letterSpacing: 0.5,
    );

    Color _tileBackgroundColor = _getTileBackgroundColor(
      isSelected: _isSelected,
      isItemTitle: _isItemsTitle,
    );

    Function _onTap = _toggleOnTapEvent(
      isSelected: _isSelected,
      isItemTitle: _isItemsTitle,
      callback: () => onItemTap(item),
    );

    Icon _checkIcon = _getCheckBoxIcon(
      isSelected: _isSelected,
      isItemsTitle: _isItemsTitle,
    );

    Row _priceAndCheck = (!_isItemsTitle && _isSelected)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_getItemPrice(item: item) > Numbers.asDouble(Numbers.zero))
                Text(
                  'R${_getItemPrice(item: item) * item.quantity}',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: (_screenHeightTwoPercent - Numbers.two),
                  ),
                ),
              Separator(dimension: Dimension.width),
              Icon(Icons.check, color: kPrimaryColor),
            ],
          )
        : null;

    return ListTile(
      leading: isLongPress ? _checkIcon : null,
      tileColor: _tileBackgroundColor,
      contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      title: Text('${item.name}', style: _itemNameStyle),
      onTap: _onTap,
      onLongPress: (_isItemsTitle || (onItemLongPress == null))
          ? null
          : () => onItemLongPress(item),
      trailing: _priceAndCheck,
    );
  }
}
