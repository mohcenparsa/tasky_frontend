import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:tasky/src/components/task/task_item_widget.dart';
import 'package:tasky/src/components/task/task_details_page.dart';
import 'package:tasky/src/models/task_item.dart';

class TasksListWidget extends StatelessWidget {
  final List<TaskItem> filteredTasks;
  final Function(String) onDelete;

  const TasksListWidget({
    super.key,
    required this.filteredTasks,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          return TaskItemWidget(
            task: filteredTasks[index],
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsPage(
                    task: filteredTasks[index],
                  ),
                ),
              );
            },
            onDelete: () async {
              // Handle delete task
              if (await confirm(context)) {
                onDelete(filteredTasks[index].id);
              }
            },
          );
        },
      ),
    );
  }
}
