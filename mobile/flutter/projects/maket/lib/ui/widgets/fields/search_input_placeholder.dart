import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/numbers.dart';

class SearchInputPlaceholder extends StatelessWidget {
  final String hint;
  final Function onTap;

  const SearchInputPlaceholder({this.hint, this.onTap});

  @override
  Widget build(BuildContext context) {
    final TextStyle _style = TextStyle(
      color: kTextSecondaryColor,
      fontSize: (Numbers.size(
            context: context,
            percent: Numbers.four,
            dimension: Dimension.width,
          ) -
          Numbers.one),
    );

    return GestureHandler(
      child: Container(
        child: PaddingView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, color: kTextSecondaryColor),
              Separator(
                dimension: Dimension.width,
                distanceAsPercent: Numbers.one,
              ),
              Text(hint, style: _style)
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
