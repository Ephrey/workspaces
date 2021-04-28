import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/buttons/base_button.dart';

class ActionButton extends BaseActionButton {
  final ButtonType buttonType;
  final String text;
  final IconData icon;
  final Function onPressed;
  final Position contentPosition;
  final Position iconPosition;

  ActionButton({
    this.buttonType: ButtonType.primary,
    this.text,
    this.icon,
    this.onPressed,
    this.contentPosition,
    this.iconPosition: Position.left,
  })  : assert(text != null),
        assert(onPressed != null);
}
