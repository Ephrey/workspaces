import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todoey/models/task.dart';

class TasksModel extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView<Task>(_tasks);

  int get length => _tasks.length;

  int get undoneLength => getUndone().length;

  void add(String newName) {
    _tasks.add(Task(name: newName));
    notifyListeners();
  }

  void setAsDone(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void delete(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  List<Task> getUndone() {
    return _tasks.where((task) => !task.isDone).toList();
  }
}
