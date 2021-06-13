import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/buttons/base/base_button.dart';

class ActionButton extends BaseActionButton {
  final ButtonType buttonType;
  final String text;
  final IconData icon;
  final Function onPressed;
  final Position contentPosition;
  final Position iconPosition;
  final bool disabled;
  final bool loading;
  final Status status;

  ActionButton({
    this.buttonType: ButtonType.primary,
    this.text,
    this.icon,
    this.onPressed,
    this.contentPosition,
    this.iconPosition: Position.left,
    this.disabled: false,
    this.loading: false,
    this.status: Status.normal,
  })  : assert(text != null),
        assert(onPressed != null);
}
