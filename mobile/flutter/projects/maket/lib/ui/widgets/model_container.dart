import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/utils/numbers.dart';

class ModelContainer extends StatelessWidget {
  final Widget content;

  ModelContainer({@required this.content}) : assert(content != null);

  @override
  Widget build(BuildContext context) {
    BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(Numbers.eighteen.toDouble()),
      color: Colors.white,
    );

    return Container(
      decoration: _boxDecoration,
      margin: EdgeInsets.symmetric(
        horizontal: Numbers.eleven.toDouble(),
        vertical: Numbers.twenty.toDouble(),
      ),
      child: PaddingView(
        padding: EdgeInsets.symmetric(
          horizontal: Numbers.twenty.toDouble(),
          vertical: Numbers.thirtyFour.toDouble(),
        ),
        child: content,
      ),
    );
  }
}
