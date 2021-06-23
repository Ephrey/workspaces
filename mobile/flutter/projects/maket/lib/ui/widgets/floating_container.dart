import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

final double _horizontal = Numbers.asDouble(Numbers.eighteen);
final double _vertical = Numbers.asDouble(Numbers.twentyFive);

class FloatingContainer extends StatelessWidget {
  final Widget content;
  final AlignmentGeometry position;
  final Color backgroundColor;
  final int widthDivideBy;

  FloatingContainer({
    @required this.content,
    this.position: Alignment.bottomCenter,
    this.backgroundColor: kWhite,
    this.widthDivideBy: Numbers.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AlignedView(
      position: position,
      child: PaddingView(
        horizontal: _horizontal,
        vertical: _vertical,
        child: Container(
          width: ScreenSize(context: context).width / widthDivideBy,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(
              kFloatingContainerBorderRadius,
            ),
          ),
          child: PaddingView(
            horizontal: _vertical,
            vertical: _horizontal,
            child: content,
          ),
        ),
      ),
    );
  }
}
