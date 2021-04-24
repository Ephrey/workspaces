import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/constants/constants.dart';
import 'package:todoey/models/tasks.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskName;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 30.0,
            ),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            decoration: kInputDecoration,
            onChanged: (userInput) => (newTaskName = userInput),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white, fontSize: 17.0),
            ),
            onPressed: () {
              context.read<TasksModel>().add(newTaskName);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
