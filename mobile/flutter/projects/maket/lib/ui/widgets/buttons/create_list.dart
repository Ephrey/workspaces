import 'package:flutter/material.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/utils/gesture_handler.dart';

class CreateListButton extends StatelessWidget {
  final Function onTap;

  CreateListButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Text(
        'Add List',
        style: kCreateListAndItemsButtonStyle.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
      onTap: onTap,
    );
  }
}
