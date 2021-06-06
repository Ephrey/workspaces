import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/list/list_more_info.dart';
import 'package:maket/ui/widgets/list/list_name.dart';
import 'package:maket/ui/widgets/on_long_press_actions.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/snackbar/hide_snackbar.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';

import 'list_subtitle.dart';

class ShoppingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Container(
        color: kWhite,
        child: PaddingView(
          vertical: Numbers.size(context: context, percent: Numbers.two) +
              Numbers.one,
          child: Row(
            children: [
              // _CheckBoxIcon(icon: Icons.check_box),
              // Separator(
              //   dimension: Dimension.width,
              //   distanceAsPercent: Numbers.seven,
              // ),
              _ListInfo(),
              _ArrowIcon(),
            ],
          ),
        ),
      ),
      onTap: () => print('List typed ...'),
      onLongPress: () => showSnackBar(
        context: context,
        content:
            OnLongPressActions(onCancel: () => hideSnackBar(context: context)),
        duration: kOneYearDuration,
      ),
    );
  }
}

class _ListInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListName(name: 'Birthday Party'),
          Separator(distanceAsPercent: Numbers.one),
          ListSubTitle(text: 'Subtitle'),
          Separator(distanceAsPercent: Numbers.one),
          ListItemCountAndCreateDate(),
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

  _CheckBoxIcon({@required this.icon}) : assert(icon != null);

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Icon(icon, color: kPrimaryColor),
      onTap: () => print('Icon tapped ...'),
    );
  }
}
