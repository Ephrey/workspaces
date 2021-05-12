import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/numbers.dart';

class OnLongPressActions extends StatelessWidget {
  final Function onCancel;

  OnLongPressActions({this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PaddingView(
        vertical: Numbers.two.toDouble(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureHandler(child: _Text(text: 'Cancel'), onTap: onCancel),
            _Text(text: '2'),
            _ActionButtons(),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  final Function onTap;

  _Text({@required this.text, this.onTap}) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    double _fontSize =
        (Numbers.size(context: context, percent: Numbers.two) - Numbers.three);

    TextStyle _style = TextStyle(
      fontSize: _fontSize,
      fontWeight: FontWeight.w600,
    );

    return GestureHandler(
      child: Text(text, style: _style),
      onTap: onTap,
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Icon(icon: Icons.check_box_outlined),
        Separator(dimension: Dimension.width),
        _Icon(icon: Icons.delete_forever_outlined),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;

  const _Icon({@required this.icon}) : assert(icon != null);

  @override
  Widget build(BuildContext context) {
    final double _iconSize =
        (Numbers.size(context: context, percent: Numbers.three) -
            Numbers.three);

    return Icon(icon, color: kTextPrimaryColor, size: _iconSize);
  }
}
