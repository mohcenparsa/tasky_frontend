import 'package:flutter/material.dart';
import 'package:tasky/src/helpers/color_utils.dart';
import 'package:tasky/src/models/task_item.dart';

class TaskNameAndStatus extends StatelessWidget {
  final TaskItem task;

  const TaskNameAndStatus({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            task.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          task.status,
          style: TextStyle(
            color: getStatusColor(task.status),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
