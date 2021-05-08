import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class ShoppingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kSecondaryColor),
      child: PaddingView(
        vertical: 20.0,
        child: Row(
          children: [
            Icon(Icons.check_box, color: kPrimaryColor),
            Separator(
              dimension: Dimension.width,
              distanceAsPercent: Numbers.seven,
            ),
            ExpandedView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visitor meal',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: Numbers.seventeen.toDouble(),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Separator(distanceAsPercent: Numbers.one),
                  Text(
                    'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.',
                    style: TextStyle(
                      color: kTextSecondaryColor,
                      fontSize: Numbers.fifteen.toDouble(),
                    ),
                  ),
                  Separator(distanceAsPercent: Numbers.two),
                  Text(
                    '0 item * 10 Feb. 2021',
                    style: TextStyle(
                      color: kTextSecondaryColor,
                      fontSize: Numbers.fifteen.toDouble(),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: 40.0,
              color: kTextSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
