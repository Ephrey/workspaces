import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';

AppBar appBar({
  Widget title,
  Widget leadingIcon,
  Color backgroundColor: kTransparentColor,
}) {
  return AppBar(
    automaticallyImplyLeading: (leadingIcon != null),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: backgroundColor,
    leading: leadingIcon,
    title: title,
  );
}
