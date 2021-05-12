import 'package:flutter/material.dart';
import 'package:maket/utils/numbers.dart';

void showSnackBar({
  @required BuildContext context,
  @required Widget content,
  Duration duration: const Duration(seconds: Numbers.three),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      duration: duration,
      padding: EdgeInsets.all(0.0),
    ),
  );
}
