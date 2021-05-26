import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/utils/numbers.dart';

class Loading extends StatelessWidget {
  final Color backgroundColor;

  Loading({this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final _loader = CenteredView(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ),
    );

    return (backgroundColor != null)
        ? Container(
            color: backgroundColor,
            padding: EdgeInsets.all(Numbers.size(
              context: context,
              percent: Numbers.three,
              dimension: Dimension.width,
            )),
            child: _loader,
          )
        : _loader;
  }
}
