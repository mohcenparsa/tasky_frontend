import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/src/components/common/thumbnail_image.dart';

class ImagePickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final List<XFile>? mediaFileList;
  final String? pickImageError;
  final void Function(File?)? onChanged;
  final String? Function(File?)? validator;

  const ImagePickerFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.mediaFileList,
    this.pickImageError,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _showImageSourceSelector(context);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _getImageWidget(),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _getImageWidget() {
    return mediaFileList != null && mediaFileList!.isNotEmpty
        ? ThumbnailImage(imageUrl: mediaFileList![0].path)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 8,
              ), // Adds some space between the text and the icon
              Image.asset(
                'assets/images/image_picker_icon.png',
                width: 40,
                height: 40,
              ),
            ],
          );
  }

  void _showImageSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a picture'),
                onTap: () {
                  _getImage(ImageSource.camera, context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery, context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        controller.text = imageFile.path;
        if (onChanged != null) {
          onChanged!(imageFile);
        }
      }
    } catch (e) {
      // Handle error
    }
  }
}
