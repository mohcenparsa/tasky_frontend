import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tasky/config/app_config.dart';
import 'package:tasky/src/components/common/custom_image_picker.dart';
import 'package:tasky/src/components/form/custom_date_picker.dart';
import 'package:tasky/src/components/form/custom_dropdown_field_icon.dart';
import 'package:tasky/src/components/form/custom_text_field.dart';
import 'package:tasky/src/components/form/validators.dart';
import 'package:tasky/src/components/layouts/page_layout.dart';
import 'package:tasky/src/constants/dropdown_options.dart';
import 'package:tasky/src/services/image_upload_service.dart';
import 'package:tasky/src/services/task_service.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({
    super.key,
  });

  @override
  CreateTaskPageState createState() => CreateTaskPageState();
}

class CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  String priority = 'low';
  DateTime dueDate = DateTime.now();
  Uint8List? _imageBytes;
  String? _imageName;
  String? _uploadedImageUrl;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_imageBytes != null && _imageName != null) {
        final imageUrl =
            await ImageUploadService.uploadImage(_imageBytes!, _imageName!);
        _uploadedImageUrl = imageUrl;

        if (imageUrl != null) {
          var createResult = await _createTask();
          if (createResult == true) {
            Navigator.of(context).pop(true);
          } else {
            _showSnackBar('Task creation failed');
          }
        } else {
          _showSnackBar('Image upload failed');
        }
      } else {
        _showSnackBar('Please select an image');
      }
    }
  }

  Future<bool> _createTask() async {
    return await TaskService.createTask(
      title: title.text,
      desc: desc.text,
      priority: priority,
      image: '${AppConfig.imageApi}$_uploadedImageUrl',
      dueDate: dueDate,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: PageLayout(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomImagePicker(
                imageBytes: _imageBytes,
                labelText: 'Select Image',
                onChanged: (bytes, fileName, fileType) {
                  setState(() {
                    _imageBytes = bytes;
                    _imageName = fileName;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: title,
                labelText: 'Task Title',
                validator: requiredValidator,
              ),
              CustomTextField(
                controller: desc,
                labelText: 'Description',
                validator: requiredValidator,
              ),
              CustomDropdownFormFieldWithIcon(
                value: priority,
                options: priorityLevelWithIcon,
                onChanged: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a priority' : null,
                labelText: 'Task Priority',
              ),
              CustomDatePicker(
                label: "Due Date",
                initialDate: dueDate,
                onDatePicked: (pickedDate) {
                  setState(() {
                    dueDate = pickedDate;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
