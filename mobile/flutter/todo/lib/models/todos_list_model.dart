import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo_model.dart';

class TodosListModel extends ChangeNotifier {
  final CollectionReference db = Firestore.instance.collection('todos');

  // Read
  Future<DocumentSnapshot> getOne(int id) async {
    final snapshot = await db.document(id.toString()).get();
    return snapshot;
  }

  Future<QuerySnapshot> getAllOrderByUncompleted() async {
    final QuerySnapshot _snapshot = await db.orderBy('isDone').getDocuments();

    return _snapshot;
  }

  Future<QuerySnapshot> getCompleted() async {
    final QuerySnapshot _snapshot = await db
        .where('isDone', isEqualTo: true)
        .orderBy('completeTime', descending: true)
        .getDocuments();

    return _snapshot;
  }

  Future<QuerySnapshot> getUnCompleted() async {
    final QuerySnapshot _snapshot = await db
        .where('isDone', isEqualTo: false)
        .orderBy('createTime', descending: true)
        .getDocuments();

    return _snapshot;
  }

  // Create
  void add(Todo todo) async {
    await db
        .document(todo.id.toString())
        .setData(todo.toMap(todo))
        .then((value) => notifyListeners());
  }

  // Update
  Future<bool> update(Todo todo) async {
    return await db.document(todo.id.toString()).updateData({
      'task': todo.task,
      'note': todo.note,
      'updateTime': new DateTime.now(),
    }).then((value) {
      notifyListeners();
      return true;
    }, onError: (onError) => false);
  }

  // Delete
  void deleteOne({int todoId}) {
    db.document(todoId.toString()).delete().then((value) => notifyListeners());
  }

  void setAsCompleted({Todo todo}) async {
    await db.document(todo.id.toString()).setData(
        {'isDone': true, 'completeTime': new DateTime.now()},
        merge: true).then((value) {
      notifyListeners();
      return true;
    }, onError: (error) => print(error.toString()));
  }
}
