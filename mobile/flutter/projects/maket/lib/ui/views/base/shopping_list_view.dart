import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/circle_button.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/utils/numbers.dart';

class ShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      withSafeArea: false,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300.0,
                color: kPrimaryColor,
                child: PaddingView(
                  vertical: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NavBar(color: kTextPrimaryColor),
                      Text(
                        'Hello',
                        style: TextStyle(
                          color: kTextPrimaryColor,
                          fontSize: Numbers.forty.toDouble(),
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          AlignedView(
            child: PaddingView(
              child: CircleButton(
                icon: Icons.add,
                backgroundColor: kPrimaryColor,
                iconColor: kTextPrimaryColor,
                buttonSize: 70.0,
              ),
              vertical: 40.0,
            ),
            position: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
