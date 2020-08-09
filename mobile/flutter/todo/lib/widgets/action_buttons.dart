import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/widgets/buttons/delete.dart';
import 'package:todo/widgets/buttons/set_as_done.dart';
import 'package:todo/widgets/buttons/edit.dart';

class ActionButtons extends StatelessWidget {
  final Todo todo;
  final TodosListModel model;
  final BoxConstraints parentSize;

  ActionButtons({Key key, this.todo, this.model, this.parentSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    final _gap = SizedBox(width: _deviceSize.width * .03);
    final _isDone = todo.isDone;

    final List<Widget> _buttons = <Widget>[
      Delete(todo: todo, model: model, parentSize: parentSize),
      if (!_isDone) _gap,
      if (!_isDone) SetAsDone(todo: todo, model: model, parentSize: parentSize),
      if (!_isDone) _gap,
      if (!_isDone) Edit(todo: todo, model: model, parentSize: parentSize),
    ];

    return Row(children: _buttons);
  }
}
