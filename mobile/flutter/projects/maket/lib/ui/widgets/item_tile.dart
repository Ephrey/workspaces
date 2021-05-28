import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ItemTitle extends StatelessWidget {
  final Map item;
  final Function onItemTap;
  final Function onItemLongPress;

  const ItemTitle({
    @required this.item,
    this.onItemTap,
    this.onItemLongPress,
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
    if (isSelected) return Numbers.zero.toDouble();

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

  Function _toggleOnTapEvent({
    bool isSelected,
    bool isItemTitle,
    Function callback,
  }) {
    if (isSelected || isItemTitle) return null;
    return callback;
  }

  @override
  Widget build(BuildContext context) {
    bool _isSelected = item['select'] != null ? item['select'] : false;

    double _screenHeightTwoPercent =
        Numbers.size(context: context, percent: Numbers.two);

    bool _isItemsTitle = item['type'] != null;

    double _horizontalPadding = _getTileHorizontalPadding(
      context: context,
      isSelected: _isSelected,
      isItemTitle: _isItemsTitle,
      screenHeightTwoPercent: _screenHeightTwoPercent,
    );

    TextStyle _itemNameStyle = TextStyle(
      color: (!_isItemsTitle) ? kPrimaryColor : kTextSecondaryColor,
      fontSize: (_screenHeightTwoPercent - Numbers.two),
      fontWeight: (!_isItemsTitle) ? FontWeight.w400 : FontWeight.w700,
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

    Text _price = (item['price'] != null)
        ? Text(
            'R${item['price'] * item['quantity']}',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: (_screenHeightTwoPercent - Numbers.two),
              letterSpacing: 0.5,
            ),
          )
        : Text('');

    Row _priceAndCheck = (!_isItemsTitle && _isSelected)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _price,
              Separator(dimension: Dimension.width),
              Icon(Icons.check, color: kPrimaryColor),
            ],
          )
        : null;

    return ListTile(
      leading: _checkIcon,
      tileColor: _tileBackgroundColor,
      contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      title: Text('${item['name']}', style: _itemNameStyle),
      onTap: _onTap,
      onLongPress: (_isItemsTitle || (onItemLongPress == null))
          ? null
          : () => onItemLongPress(item),
      trailing: _priceAndCheck,
    );
  }
}
