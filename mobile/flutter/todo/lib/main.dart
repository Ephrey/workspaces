import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/theme.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/screens/home_screen.dart';

void main() => runApp(
      ChangeNotifierProvider(
        child: Todo(),
        create: (context) => TodosListModel(),
      ),
    );

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Home(),
    );
  }
}
