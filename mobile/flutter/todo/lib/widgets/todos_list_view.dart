import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/messages.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widgets/todo_status.dart';
import 'package:todo/utils/custom_model_bottom_sheet.dart';
import 'package:todo/screens/todo_details.dart';

class TodosListView extends StatelessWidget {
  final Future<QuerySnapshot> todos;
  final String screenTitle;

  TodosListView({Key key, this.todos, this.screenTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: todos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data.documents.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return _ListTile(
                    todo: Todo.fromSnapshot(snapshot.data.documents[index]));
              },
            );
          } else {
            return Messages(screen: screenTitle);
          }
        }

        return Center(
          child: Text(snapshot.error.toString()),
        );
      },
    );
  }
}

class _ListTile extends StatelessWidget {
  final Todo todo;

  _ListTile({Key key, this.todo}) : super(key: key);

  String trimSubTitle(String text) {
    final newText = text.split(' ');
    return newText.length < 15 ? text : newText.take(15).join(' ') + ' ...';
  }

  @override
  Widget build(BuildContext context) {
    final _title = Text('${todo.task}');
    final _subTitle =
        todo.note.isNotEmpty ? Text('${trimSubTitle(todo.note)}') : null;

    return ListTile(
      title: _title,
      subtitle: _subTitle,
      trailing: TodoStatus(todo: todo),
      onTap: () => showCustomBottomModel(context, TodoDetails(todoId: todo.id)),
    );
  }
}
