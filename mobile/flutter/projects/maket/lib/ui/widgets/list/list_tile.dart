import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/list/list_more_info.dart';
import 'package:maket/ui/widgets/list/list_name.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/numbers.dart';

import 'list_subtitle.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingListModel list;
  final Function onTap;
  final Function onLongPress;
  final bool longPressTriggered;

  ShoppingListTile({
    this.list,
    this.onTap,
    this.onLongPress,
    this.longPressTriggered: false,
  });

  dynamic _getIcon({bool selected}) {
    return (selected && longPressTriggered)
        ? Icons.check_circle_rounded
        : Icons.radio_button_unchecked_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Container(
        color: (!list.selected) ? kWhite : kSecondaryColor,
        child: PaddingView(
          vertical: Numbers.size(context: context, percent: Numbers.two) +
              Numbers.one,
          child: Row(
            children: [
              if (list.selected || longPressTriggered)
                _CheckBoxIcon(
                  icon: _getIcon(selected: list.selected),
                  color: list.selected ? kPrimaryColor : kElevationColor,
                ),
              if (list.selected || longPressTriggered)
                Separator(
                  dimension: Dimension.width,
                  distanceAsPercent: Numbers.seven,
                ),
              _ListInfo(list: list, longPressTriggered: longPressTriggered),
              if (!longPressTriggered) _ArrowIcon(),
            ],
          ),
        ),
      ),
      onTap: () => onTap(list: list),
      onLongPress: (!longPressTriggered && onLongPress != null)
          ? () => onLongPress(list: list)
          : null,
    );
  }
}

class _ListInfo extends StatelessWidget {
  final ShoppingListModel list;
  final bool longPressTriggered;

  _ListInfo({this.list, this.longPressTriggered});

  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListName(name: list.name),
          if (list.description.isNotEmpty)
            Separator(distanceAsPercent: Numbers.one),
          if (list.description.isNotEmpty) ListSubTitle(text: list.description),
          Separator(distanceAsPercent: Numbers.one),
          ListItemCountAndCreateDate(
              list: list, longPressTriggered: longPressTriggered),
        ],
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _size =
        Numbers.size(context: context, percent: Numbers.four) + Numbers.three;

    return Icon(
      Icons.keyboard_arrow_right,
      size: _size,
      color: kTextSecondaryColor,
    );
  }
}

class _CheckBoxIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  _CheckBoxIcon({@required this.icon, this.color}) : assert(icon != null);

  @override
  Widget build(BuildContext context) {
    return GestureHandler(child: Icon(icon, color: color));
  }
}
