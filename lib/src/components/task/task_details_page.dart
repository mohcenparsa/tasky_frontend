import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/src/components/common/full_with_image.dart';
import 'package:tasky/src/components/form/custom_date_picker.dart';
import 'package:tasky/src/components/form/custom_dropdown_field.dart';
import 'package:tasky/src/components/form/custom_text_field.dart';
import 'package:tasky/src/components/form/form_fields.dart';
import 'package:tasky/src/components/layouts/page_layout.dart';
import 'package:tasky/src/constants/dropdown_options.dart';
import 'package:tasky/src/models/task_item.dart';
import 'package:tasky/src/services/task_service.dart';

class TaskDetailsPage extends StatefulWidget {
  final TaskItem task;

  const TaskDetailsPage({
    super.key,
    required this.task,
  });

  @override
  TaskDetailsPageState createState() => TaskDetailsPageState();
}

class TaskDetailsPageState extends State<TaskDetailsPage> {
  late String status;
  late String priority;
  late String description;
  late DateTime date;
  bool readOnly = true;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    status = widget.task.status;
    priority = widget.task.priority;
    date = widget.task.dueDate;
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.desc);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Task Details'),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'edit') {
                  setState(() {
                    readOnly = false;
                  });
                } else if (value == 'delete') {
                  _onDelete();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FullWidthImage(imageUrl: widget.task.image),
                CustomTextField(
                  controller: titleController,
                  labelText: 'Title',
                  keyboardType: TextInputType.text,
                  readOnly: readOnly,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: descriptionController,
                  labelText: 'Description',
                  keyboardType: TextInputType.multiline,
                  readOnly: readOnly,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
                CustomDatePicker(
                  label: "Due Date",
                  initialDate: date,
                  onDatePicked: (pickedDate) {
                    if (readOnly) {
                      setState(() {
                        date = pickedDate;
                      });
                    }
                  },
                ),
                CustomDropdownFormField(
                  value: status,
                  options: statusOptions,
                  labelText: 'Status',
                  onChanged: !readOnly
                      ? (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              status = newValue;
                            });
                          }
                        }
                      : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                ),
                CustomDropdownFormField(
                  value: priority,
                  options: priorityLevel,
                  labelText: 'Priority',
                  onChanged: !readOnly
                      ? (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              priority = newValue;
                            });
                          }
                        }
                      : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                ),
                Center(
                    child: Container(
                        color: Colors.white,
                        constraints:
                            const BoxConstraints(maxWidth: 200, maxHeight: 200),
                        child: QrImageView(data: widget.task.id))),
                if (!readOnly)
                  SignUpButton(
                    label: "Save",
                    formKey: _formKey,
                    onPressed: () async {
                      print('SignUpButton');
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        var result = await TaskService.updateTask(
                            id: widget.task.id,
                            title: titleController.text,
                            desc: descriptionController.text,
                            priority: priority,
                            image: widget.task.image,
                            dueDate: date);
                        if (result == true) {
                          readOnly = true;
                        }
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDelete() {
    // Handle delete action
  }

  void _onEdit() {
    // Handle edit action
  }
}
