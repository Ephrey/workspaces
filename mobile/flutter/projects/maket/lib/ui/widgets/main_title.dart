import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/utils/numbers.dart';

class MainTitle extends StatelessWidget {
  final String text;
  final Alignment position;
  final TextAlign textAlign;

  MainTitle({
    @required this.text,
    this.position: Alignment.centerLeft,
    this.textAlign: TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: Numbers.size(
        context: context,
        percent: Numbers.seven,
        dimension: Dimension.width,
      ),
    );

    return AlignedView(
      position: position,
      child: Text(text, textAlign: textAlign, style: _textStyle),
    );
  }
}
