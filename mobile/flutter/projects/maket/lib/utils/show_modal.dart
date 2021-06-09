import 'package:flutter/material.dart';

void showModal({
  @required BuildContext context,
  @required Widget child,
  bool isScrollControlled: true,
  bool isDismissible: true,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (_) => child,
    isDismissible: isDismissible,
  );
}
