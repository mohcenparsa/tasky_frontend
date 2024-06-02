import 'package:flutter/material.dart';
import 'package:tasky/src/components/common/avatar.dart';
import 'package:tasky/src/components/common/task_image.dart';
import 'package:tasky/src/components/task/task_action_menu.dart';
import 'package:tasky/src/components/task/task_description.dart';
import 'package:tasky/src/components/task/task_name_status.dart';
import 'package:tasky/src/components/task/task_priority_date.dart';
import 'package:tasky/src/models/task_item.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskItem task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskImage(
              radius: 25,
              imageUrl: task.image,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskNameAndStatus(task: task),
                  const SizedBox(height: 5),
                  TaskDescription(description: task.desc),
                  const SizedBox(height: 5),
                  TaskPriorityAndDate(task: task),
                ],
              ),
            ),
            TaskActionMenu(onEdit: onEdit, onDelete: onDelete),
          ],
        ),
      ),
    );
  }
}
