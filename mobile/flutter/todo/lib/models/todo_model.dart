import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/uuid.dart';

class Todo {
  int id;
  final String task;
  final String note;
  bool isDone;
  final DateTime completeTime;
  final DateTime createTime;

  Todo({
    int id,
    @required this.task,
    this.note: '',
    this.isDone: false,
    DateTime completeTime,
    DateTime createTime,
  })  : id = id ?? Uuid().uuid,
        completeTime = completeTime ?? new DateTime.now(),
        createTime = createTime ?? new DateTime.now();

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
        id: map['id'],
        task: map['task'],
        note: map['note'],
        isDone: map['isDone']);
  }

  factory Todo.fromSnapshot(DocumentSnapshot todo) {
    return Todo.fromMap(todo.data);
  }

  Map<String, dynamic> toMap(Todo todo) => {
        'id': todo.id,
        'task': todo.task,
        'note': todo.note,
        'isDone': todo.isDone,
        'completeTime': todo.completeTime,
        'createTime': todo.createTime
      };

  String asString(Todo todo) => "${todo.isDone}";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Todo && hashCode == id;
}
