import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class BaseActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Position iconPosition;
  final Position contentPosition;
  final ButtonType buttonType;
  final Function onPressed;
  final bool disabled;

  const BaseActionButton({
    this.icon,
    this.text,
    this.iconPosition: Position.left,
    this.contentPosition: Position.start,
    this.buttonType: ButtonType.primary,
    this.onPressed,
    this.disabled: false,
  });

  @override
  Widget build(BuildContext context) {
    Color _buttonBgColor;
    Color _textColor;
    Color _buttonBorderColor;
    FontWeight _fontWeight = FontWeight.w600;

    Function _onPressed = onPressed;

    double _sixPercentOfScreenHeight = Math.percentage(
      percent: Numbers.six,
      total: ScreenSize(context: context).height,
    );

    double _buttonHeight =
        _sixPercentOfScreenHeight <= kDefaultActionButtonHeight
            ? _sixPercentOfScreenHeight
            : kDefaultActionButtonHeight;

    double _iconMarginRight = (iconPosition == Position.right)
        ? Math.percentage(
            percent: Numbers.ten,
            total: _buttonHeight,
          )
        : 0.0;
    double _iconMarginLeft = (iconPosition == Position.left)
        ? Math.percentage(
            percent: Numbers.ten,
            total: _buttonHeight,
          )
        : 0.0;

    if (buttonType == ButtonType.primary) {
      _buttonBgColor = kPrimaryColor;
      _textColor = kTextPrimaryColor;
    }

    if (buttonType == ButtonType.secondary) {
      _buttonBgColor = kBgPrimaryColor;
      _textColor = kPrimaryColor;
      _buttonBorderColor = _textColor;
    }

    if (buttonType == ButtonType.disable) {
      _buttonBgColor = (icon != null) ? kSecondaryColor : kSecondaryColor;
      _textColor = kTextSecondaryColor;
      _buttonBorderColor = (icon == null) ? kSecondaryColor : null;
      _onPressed = null;
    }

    if (disabled) {
      _onPressed = null;
      _buttonBorderColor = kSecondaryColor;
      _textColor = kTextSecondaryColor;
      _buttonBgColor = kBgPrimaryColor;
    }

    TextStyle _textStyle = TextStyle(
      color: _textColor,
      fontSize: Math.percentage(
        percent: Numbers.thirtyTwo,
        total: _buttonHeight,
      ),
      fontWeight: _fontWeight,
    );

    ButtonStyle _buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        Size.fromHeight(_buttonHeight + Numbers.ten),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(_buttonBgColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: Math.percentage(
            percent: Numbers.twentyTwo,
            total: _buttonHeight,
          ),
          horizontal: Math.percentage(
            percent: Numbers.thirtyTwo,
            total: _buttonHeight,
          ),
        ),
      ),
      side: _buttonBorderColor != null
          ? MaterialStateProperty.all<BorderSide>(
              BorderSide(color: _buttonBorderColor),
            )
          : null,
    );

    dynamic _icon = (icon != null)
        ? PaddingView(
            padding: EdgeInsets.only(
              right: _iconMarginLeft,
              left: _iconMarginRight,
            ),
            child: Icon(
              icon,
              color: _textColor,
              size: Math.percentage(
                percent: Numbers.eighty,
                total: _buttonHeight,
              ),
            ),
          )
        : null;

    return TextButton(
      style: _buttonStyle,
      onPressed: _onPressed,
      child: Row(
        mainAxisAlignment: contentPosition == Position.center
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (_icon != null && iconPosition == Position.left) _icon,
          Text(text, style: _textStyle),
          if (_icon != null && iconPosition == Position.right) _icon,
        ],
      ),
    );
  }
}
