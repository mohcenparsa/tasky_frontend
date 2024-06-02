import 'package:flutter/material.dart';
import 'package:tasky/src/helpers/color_utils.dart';
import 'package:tasky/src/models/task_item.dart';

class TaskPriorityAndDate extends StatelessWidget {
  final TaskItem task;

  const TaskPriorityAndDate({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          task.priority,
          style: TextStyle(
            color: getPriorityColor(task.priority),
          ),
        ),
        Text(
          task.dueDate.toLocal().toString().split(' ')[0], // display date only
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
