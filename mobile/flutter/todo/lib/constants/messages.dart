import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final screen;

  Messages({this.screen});

  static const String noTodos = 'No todos ! Seems like you chill.';
  static const String noCompletedTodos = 'No completed tasks yet.';
  static const String nowWhat = 'Click the + button to add a todo.';

  @override
  Widget build(BuildContext context) {
    final String message = (screen == 'Completed') ? noCompletedTodos : noTodos;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message),
          SizedBox(height: 20.0),
          Text(nowWhat),
        ],
      ),
    );
  }
}
