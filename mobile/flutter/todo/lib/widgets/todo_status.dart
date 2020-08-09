import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/models/todo_model.dart';

class TodoStatus extends StatelessWidget {
  final Todo todo;

  TodoStatus({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosListModel = Provider.of<TodosListModel>(context);
    final _statusColor = todo.isDone ? Colors.green : Colors.red;
    final double _firsCircleSize = 20.0;
    final double _secondCircleSize = 19.0;

    BoxDecoration decoration({bool widthBackgroundColor: false}) {
      return BoxDecoration(
        border: Border.all(width: 2.0, color: _statusColor),
        borderRadius: BorderRadius.circular(100.0),
        color: widthBackgroundColor ? _statusColor : null,
      );
    }

    final Container _secondCircle = Container(
      width: _secondCircleSize,
      height: _secondCircleSize,
      decoration: decoration(widthBackgroundColor: true),
    );

    final Container _firstCircle = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(1.5),
      width: _firsCircleSize,
      height: _firsCircleSize,
      decoration: decoration(),
      child: todo.isDone ? _secondCircle : null,
    );

    void handleTap() => todosListModel.setAsCompleted(todo: todo);

    return !todo.isDone
        ? GestureDetector(child: _firstCircle, onTap: handleTap)
        : _firstCircle;
  }
}
