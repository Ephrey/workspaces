import 'package:flutter/material.dart';
import 'package:todo/utils/custom_model_bottom_sheet.dart';

class AddTodoButton extends StatelessWidget {
  final Widget form;

  AddTodoButton({Key key, this.form}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => showCustomBottomModel(context, form),
    );
  }
}
