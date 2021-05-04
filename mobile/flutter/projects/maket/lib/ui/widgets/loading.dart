import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/centered_view.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ),
    );
  }
}
