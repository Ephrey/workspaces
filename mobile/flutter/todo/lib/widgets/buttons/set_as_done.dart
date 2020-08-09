import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widgets/buttons/button_shape.dart';
import 'package:todo/common/colors.dart';

class SetAsDone extends StatelessWidget {
  final Todo todo;
  final TodosListModel model;
  final BoxConstraints parentSize;

  SetAsDone({
    Key key,
    this.todo,
    this.model,
    this.parentSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TodosListModel>(context);
    final _style = TextStyle(color: kWhite, fontSize: 17.0);

    final _button = FlatButton(
      child: Text('Set as Done', style: _style),
      onPressed: () => model.setAsCompleted(todo: todo),
    );

    final _setAsDoneButton = ButtonShape(
      hasWidth: false,
      parentSize: parentSize,
      color: kGreen,
      child: _button,
    );

    return Expanded(child: _setAsDoneButton);
  }
}
