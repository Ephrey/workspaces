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
  final Color flavor;

  FloatingContainer({
    @required this.content,
    this.position: Alignment.bottomCenter,
    this.flavor: kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return AlignedView(
      position: position,
      child: PaddingView(
        horizontal: _horizontal,
        vertical: _vertical,
        child: Container(
          width: ScreenSize(context: context).width,
          decoration: BoxDecoration(
            color: flavor,
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
