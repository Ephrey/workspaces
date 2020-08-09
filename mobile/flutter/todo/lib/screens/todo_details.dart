import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/widgets/action_buttons.dart';

class TodoDetails extends StatelessWidget {
  final int todoId;

  TodoDetails({Key key, this.todoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<TodosListModel>(context, listen: true);

    return FutureBuilder(
      future: _model.getOne(todoId),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Modal(content: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          final Todo _todo = Todo.fromSnapshot(snapshot.data);
          return Modal(content: DetailsContent(model: _model, todo: _todo));
        }

        return Modal(content: Center(child: Text(snapshot.error.toString())));
      },
    );
  }
}

class Modal extends StatelessWidget {
  final Widget content;

  Modal({this.content});

  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    final double _deviceHeight = _deviceSize.height;

    final EdgeInsets _padding = EdgeInsets.symmetric(
      vertical: _deviceHeight * .04,
      horizontal: _deviceSize.width * .05,
    );

    return Container(
      height: _deviceHeight * .45,
      padding: _padding,
      color: Theme.of(context).cardColor,
      child: content,
    );
  }
}

class DetailsContent extends StatelessWidget {
  final Todo todo;
  final TodosListModel model;

  DetailsContent({Key key, this.todo, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        List<Widget> children = <Widget>[
          const Text('Task Details :'),
          SizedBox(height: 5.0),
          _Details(todo: todo),
          SizedBox(height: 5.0),
          ActionButtons(todo: todo, model: model, parentSize: size),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
      },
    );
  }
}

class _Details extends StatelessWidget {
  final Todo todo;

  _Details({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _taskNameStyle = Theme.of(context).textTheme.headline5;
    final _taskNoteStyle = Theme.of(context).textTheme.headline2;

    final Column _content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(todo.task, style: _taskNameStyle),
        SizedBox(height: 10.0),
        Text(todo.note, style: _taskNoteStyle)
      ],
    );

    return Expanded(child: SingleChildScrollView(child: _content));
  }
}
