import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/tasks.dart';
import 'package:todoey/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksModel>(
      builder: (_, tasksModel, child) {
        final List<Task> tasks = tasksModel.tasks;

        if (tasksModel.length == 0) return child;

        return ListView.builder(
          itemCount: tasksModel.length,
          itemBuilder: (context, index) {
            final Task task = tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (_) => tasksModel.setAsDone(task),
              deleteTaskCallback: () => tasksModel.delete(task),
            );
          },
        );
      },
      child: Center(
        child: const Text('Tasks go here.'),
      ),
    );
  }
}
