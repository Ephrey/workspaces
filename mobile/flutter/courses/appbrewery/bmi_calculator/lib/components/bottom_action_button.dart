import 'package:bmi_calculator/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const BottomActionButton({@required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(title, style: kNavigatorButtonStyle),
        ),
        height: kBottomContainerHeight,
        color: kBottomContainerColor,
        margin: EdgeInsets.only(top: 15.0),
        padding: EdgeInsets.only(bottom: 20.0),
      ),
    );
  }
}
