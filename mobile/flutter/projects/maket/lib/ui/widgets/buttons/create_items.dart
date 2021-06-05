import 'package:flutter/material.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/utils/gesture_handler.dart';

class CreateItemsButton extends StatelessWidget {
  final Function onTap;

  CreateItemsButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureHandler(
      child: Text(
        'Create Items',
        style: kCreateListAndItemsButtonStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
