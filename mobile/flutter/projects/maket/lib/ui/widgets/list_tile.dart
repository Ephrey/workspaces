import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/dot_separator.dart';
import 'package:maket/ui/widgets/on_select_lists_action.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_snackbar.dart';

class ShoppingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Container(
        // color: kSecondaryColor,
        child: PaddingView(
          vertical: Numbers.size(context: context, percent: Numbers.two) +
              Numbers.one,
          child: Row(
            children: [
              _CheckBoxIcon(icon: Icons.check_box),
              Separator(
                dimension: Dimension.width,
                distanceAsPercent: Numbers.seven,
              ),
              _ListInfo(),
              // _ArrowIcon(),
            ],
          ),
        ),
      ),
      onTap: () => print('List typed ...'),
      onLongPress: () => showSnackBar(
        context: context,
        content: OnSelectListsAction(),
        duration: Duration(days: 365),
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
          _ListName(name: 'Birthday Party'),
          Separator(distanceAsPercent: Numbers.one),
          _SubTitle(text: 'Lorem ipsum dolor sit amet. Lorem ipsum dolor.'),
          Separator(distanceAsPercent: Numbers.two),
          _ListMoreInfo()
        ],
      ),
    );
  }
}

class _ListName extends StatelessWidget {
  final String name;

  _ListName({@required this.name}) : assert(name != null);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = TextStyle(
      color: kPrimaryColor,
      fontSize:
          Numbers.size(context: context, percent: Numbers.two) - Numbers.two,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    );

    return Text(name, style: _style);
  }
}

class _ListMoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SubTitle(text: '0 item', fontWeight: FontWeight.w700),
        Separator(
          distanceAsPercent: Numbers.two,
          dimension: Dimension.width,
        ),
        DotSeparator(),
        Separator(
          distanceAsPercent: Numbers.two,
          dimension: Dimension.width,
        ),
        _SubTitle(text: '10 Feb. 2021', fontWeight: FontWeight.w700),
      ],
    );
  }
}

class _SubTitle extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;

  _SubTitle({
    @required this.text,
    this.fontWeight: FontWeight.w400,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = TextStyle(
      color: kTextSecondaryColor,
      fontSize:
          Numbers.size(context: context, percent: Numbers.two) - Numbers.four,
      fontWeight: fontWeight,
    );

    return Text(text, style: _style);
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
