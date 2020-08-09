import 'package:flutter/material.dart';
import 'package:todo/common/colors.dart';
import 'package:todo/screens/add_todo_form.dart';
import 'package:todo/utils/custom_model_bottom_sheet.dart';
import 'package:todo/widgets/buttons/button_shape.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todos_list_model.dart';

class Edit extends StatelessWidget {
  final Todo todo;
  final TodosListModel model;
  final BoxConstraints parentSize;

  Edit({Key key, this.todo, this.model, this.parentSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _button = FlatButton(
      child: Icon(Icons.edit, color: kBlack, size: 30.0),
      onPressed: () {
        Navigator.of(context).pop();
        showCustomBottomModel(context, AddTodoForm(todo: todo));
      },
    );

    final Widget _deleteButton = ButtonShape(
      hasWidth: false,
      parentSize: parentSize,
      color: kYellow,
      child: _button,
    );

    return todo.isDone ? Expanded(child: _deleteButton) : _deleteButton;
  }
}
