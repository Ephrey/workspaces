import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/constants/nav_items.dart';
import 'package:todo/widgets/todos_list_view.dart';
import 'package:todo/widgets/buttons/add_todo_button.dart';
import 'package:todo/screens/add_todo_form.dart';
import 'package:todo/widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _navIndex = 0;

  void updateNavIndex(int newNavIndex) {
    setState(() {
      _navIndex = newNavIndex;
    });
  }

  Future<QuerySnapshot> getTodos(TodosListModel model) {
    switch (_navIndex) {
      case 0:
        return model.getUnCompleted();
        break;
      case 1:
        return model.getCompleted();
        break;
      case 2:
        return model.getAllOrderByUncompleted();
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todosModel = Provider.of<TodosListModel>(context);
    final Future<QuerySnapshot> todos = getTodos(todosModel);

    final title = navItems.elementAt(_navIndex)['title'];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: TodosListView(todos: todos, screenTitle: title),
      bottomNavigationBar: BottomNavigation(
        onTap: updateNavIndex,
        navIndex: _navIndex,
      ),
      floatingActionButton: AddTodoButton(form: AddTodoForm()),
    );
  }
}
