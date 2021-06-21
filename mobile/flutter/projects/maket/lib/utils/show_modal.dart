import 'package:flutter/material.dart';

void showModal({
  @required BuildContext context,
  @required Widget child,
  bool isScrollControlled: true,
  bool isDismissible: true,
  Color backgroundColor: Colors.transparent,
}) {
  showModalBottomSheet(
    backgroundColor: backgroundColor,
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (_) => child,
    isDismissible: isDismissible,
  );
}
