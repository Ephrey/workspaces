import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class ItemTitle extends StatelessWidget {
  final dynamic item;
  final Function onItemTap;

  const ItemTitle({@required this.item, this.onItemTap}) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = ScreenSize(context: context).height;

    double _screenTwoPercent =
        Math.percentage(percent: Numbers.two, total: _screenHeight);

    bool _isItemsTitle = item['type'] == null;

    double _horizontalPadding = (_isItemsTitle)
        ? (Math.percentage(percent: Numbers.three, total: _screenHeight) -
            Numbers.three)
        : (_screenTwoPercent - Numbers.four);

    return ListTile(
      tileColor: (item['type'] == null) ? kSecondaryColor : null,
      contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      title: Text(
        '${item['name']}',
        style: TextStyle(
          color: (_isItemsTitle) ? kPrimaryColor : kTextSecondaryColor,
          fontSize: (_screenTwoPercent - Numbers.two),
          fontWeight: (_isItemsTitle) ? FontWeight.w400 : FontWeight.w900,
        ),
      ),
      onTap: () => onItemTap(item['id']),
    );
  }
}
