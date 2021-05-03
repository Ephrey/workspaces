import 'package:flutter/material.dart';

void showModel({
  @required BuildContext context,
  @required Widget child,
  bool isScrollControlled: false,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (BuildContext context) {
      return child;
    },
  );
}
