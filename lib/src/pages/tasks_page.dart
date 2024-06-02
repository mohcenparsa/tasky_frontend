import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tasky/resources/widget/loader_widget.dart';
import 'package:tasky/src/components/common/appbar_actions.dart';
import 'package:tasky/src/components/layouts/page_layout.dart';
import 'package:tasky/src/components/task/task_details_page.dart';
import 'package:tasky/src/components/tasks/tasks_list_widget.dart';
import 'package:tasky/src/constants/dropdown_options.dart';
import 'package:tasky/src/pages/create_task_page.dart';
import 'package:tasky/src/pages/qr_scanner_page.dart';
import 'package:tasky/src/services/task_service.dart';

import '../components/task/filter_buttons.dart';
import '../components/task/task_item_widget.dart';
import '../models/task_item.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  TaskListPageState createState() => TaskListPageState();
}

class TaskListPageState extends State<TaskListPage> {
  List<String> filters = allStatusOptions;
  String selectedFilter = 'All';
  List<TaskItem> allTasks = [];
  List<TaskItem> filteredTasks = [];
  bool isLoading = true;
  TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      List<TaskItem> fetchedTasks = await TaskService.getTasks();
      setState(() {
        allTasks = fetchedTasks;
        _filterTasks();
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterTasks() {
    setState(() {
      if (selectedFilter.toLowerCase() == 'All'.toLowerCase()) {
        filteredTasks = allTasks;
      } else {
        filteredTasks = allTasks
            .where((task) =>
                task.status.toLowerCase() == selectedFilter.toLowerCase())
            .toList();
      }
    });
  }

  void _onSelectFilter(String filter) {
    setState(() {
      selectedFilter = filter.toLowerCase();
      _filterTasks();
    });
  }

  void _onDeleteTask(id) async {
    bool result = false;
    result = await taskService.deleteTask(id);
    if (result == true) {
      print("deleted");
      _fetchTasks();
    } else {
      print("delte");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: const [AppBarActions()],
      ),
      body: PageLayout(
        child: Stack(
          children: [
            isLoading
                ? const Loader()
                : Column(
                    children: [
                      FilterButtons(
                        filters: filters,
                        selectedFilter: selectedFilter,
                        onSelectFilter: _onSelectFilter,
                      ),
                      TasksListWidget(
                        filteredTasks: filteredTasks,
                        onDelete: _onDeleteTask,
                      ),
                    ],
                  ),
            Align(
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
                          _fetchTasks();
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
                          _fetchTasks();
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
