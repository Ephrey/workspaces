import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/constants.dart';
import 'package:maket/constants/enums.dart';

class BaseActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Position iconPosition;
  final Position contentPosition;
  final ButtonType buttonType;
  final Function onPressed;

  const BaseActionButton({
    this.icon,
    this.text,
    this.iconPosition: Position.left,
    this.contentPosition: Position.start,
    this.buttonType: ButtonType.primary,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    double _tenPercentOfScreenHeight = (6 * _screenSize.height) / 100;
    double _buttonHeight =
        _tenPercentOfScreenHeight <= kDefaultActionButtonHeight
            ? _tenPercentOfScreenHeight
            : kDefaultActionButtonHeight;
    print(_buttonHeight);
    Color _buttonBgColor;
    Color _textColor;
    Color _buttonBorderColor;

    Function _onPressed = onPressed;

    double _iconMarginRight =
        (iconPosition == Position.right) ? _buttonHeight : 0.0;
    double _iconMarginLeft =
        (iconPosition == Position.left) ? _buttonHeight : 0.0;

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
      _buttonBgColor = kSecondaryColor;
      _textColor = kTextSecondaryColor;
      _onPressed = null;
    }

    TextStyle _textStyle = TextStyle(color: _textColor);

    ButtonStyle _buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        Size.fromHeight(_buttonHeight),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(_buttonBgColor),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
      ),
      side: _buttonBorderColor != null
          ? MaterialStateProperty.all<BorderSide>(
              BorderSide(color: _buttonBorderColor),
            )
          : null,
    );

    dynamic _icon = (icon != null)
        ? Padding(
            padding: EdgeInsets.only(
              right: _iconMarginLeft,
              left: _iconMarginRight,
            ),
            child: Icon(icon, color: _textColor),
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
