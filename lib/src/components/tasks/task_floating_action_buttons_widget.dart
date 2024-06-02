import 'package:flutter/material.dart';
import 'package:tasky/src/pages/create_task_page.dart';
import 'package:tasky/src/pages/qr_scanner_page.dart';

class TaskFloatingActionButtonsWidget extends StatelessWidget {
  final Function() onFetchTasks;
  const TaskFloatingActionButtonsWidget({
    super.key,
    required this.onFetchTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "createTaskQrcode",
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QRScannerPage(),
                  ),
                ).then((_) {
                  onFetchTasks();
                });
              },
              child: const Icon(Icons.qr_code_scanner),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "createTaskButton",
              onPressed: () async {
                // Handle add task
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTaskPage(),
                  ),
                ).then((_) {
                  onFetchTasks();
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
