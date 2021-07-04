import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ItemTitle extends StatelessWidget {
  final ItemModel item;
  final int itemIndex;
  final Function onItemTap;
  final Function onItemLongPress;
  final bool isLongPress;

  const ItemTitle({
    @required this.item,
    this.itemIndex,
    this.onItemTap,
    this.onItemLongPress,
    this.isLongPress: false,
  }) : assert(item != null);

  Icon _getCheckBoxIcon({bool isSelected, bool isItemsTitle}) {
    if (isSelected) {
      return (!isItemsTitle)
          ? Icon(Icons.check_circle_rounded, color: kPrimaryColor)
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
    return (Numbers.size(context: context, percent: Numbers.three) -
        Numbers.three);
  }

  Color _getTileBackgroundColor({bool isSelected, bool isItemTitle}) {
    if (isItemTitle) return null;
    return (isSelected) ? kBgSecondaryColor : kWhite;
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

    final _fontSize = (_screenHeightTwoPercent - Numbers.one);

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
              : (item.bought)
                  ? kTextSecondaryColor
                  : kPrimaryColor
          : kTextSecondaryColor,
      fontSize: _fontSize,
      fontWeight: (!_isItemsTitle) ? FontWeight.w400 : FontWeight.w700,
      letterSpacing: 0.5,
      decoration:
          (item.bought) ? TextDecoration.lineThrough : TextDecoration.none,
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

    List<Widget> _priceAndCheck = [];

    if (item.bought && !_isItemsTitle && !_isSelected) {
      _priceAndCheck.add(CustomChip(item: item));
      _priceAndCheck.add(Separator(dimension: Dimension.width, thin: true));
      _priceAndCheck.add(_ItemPrice(item: item, fontSize: _fontSize));
    }

    if (_isSelected) {
      _priceAndCheck.add(Icon(Icons.check, color: kPrimaryColor));
    }

    return ListTile(
      leading: isLongPress ? _checkIcon : null,
      tileColor: _tileBackgroundColor,
      contentPadding: EdgeInsets.only(
        top: (_isItemsTitle && (itemIndex != Numbers.zero))
            ? _horizontalPadding - Numbers.fifteen
            : Numbers.asDouble(Numbers.zero),
        left: _horizontalPadding,
        right: _horizontalPadding,
      ),
      title: Text('${item.name}', style: _itemNameStyle),
      onTap: _onTap,
      onLongPress: (_isItemsTitle || (onItemLongPress == null))
          ? null
          : () => onItemLongPress(item),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: _priceAndCheck),
    );
  }
}

class _ItemPrice extends StatelessWidget {
  final ItemModel item;
  final double fontSize;

  const _ItemPrice({this.item, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      'R${Numbers.stringAsFixed(number: item.price * item.quantity)}',
      style: TextStyle(color: kPrimaryColor, fontSize: fontSize),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({@required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        '${item.price} x ${item.quantity}',
        style: TextStyle(fontSize: Numbers.asDouble(Numbers.ten)),
      ),
      padding: EdgeInsets.all(Numbers.asDouble(Numbers.two)),
      backgroundColor: kSecondaryColor,
    );
  }
}
