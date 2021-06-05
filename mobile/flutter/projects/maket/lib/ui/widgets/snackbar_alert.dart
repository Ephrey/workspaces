import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/ui/views/base/padding_view.dart';

class SnackBarAlert extends StatelessWidget {
  final String message;
  final Color textColor;

  const SnackBarAlert({
    @required this.message,
    this.textColor: kTextPrimaryColor,
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return PaddingView(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: kLetterSpacing,
        ),
      ),
    );
  }
}
