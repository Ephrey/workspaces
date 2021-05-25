import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/utils/numbers.dart';

void showSnackBar({
  @required BuildContext context,
  @required Widget content,
  Status flavor,
  Duration duration: const Duration(seconds: Numbers.three),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      duration: duration,
      padding: EdgeInsets.all(0.0),
      backgroundColor: getStatusColor(flavor),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}
