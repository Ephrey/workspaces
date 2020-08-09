import 'package:flutter/material.dart';
import 'package:todo/common/colors.dart';
import 'package:todo/widgets/buttons/button_shape.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todos_list_model.dart';

class Delete extends StatelessWidget {
  final Todo todo;
  final TodosListModel model;
  final BoxConstraints parentSize;

  Delete({Key key, this.todo, this.model, this.parentSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _button = FlatButton(
      child: Icon(Icons.delete, color: kWhite, size: 30.0),
      onPressed: () {
        Navigator.of(context).pop();
        model.deleteOne(todoId: todo.id);
      },
    );

    final Widget _deleteButton = ButtonShape(
      hasWidth: false,
      parentSize: parentSize,
      color: kRed,
      child: _button,
    );

    return todo.isDone ? Expanded(child: _deleteButton) : _deleteButton;
  }
}
