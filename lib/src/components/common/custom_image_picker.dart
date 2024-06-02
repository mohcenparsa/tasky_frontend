import 'dart:io';
import 'dart:typed_data';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class CustomImagePicker extends StatefulWidget {
  Uint8List? imageBytes;
  final String labelText;
  final void Function(Uint8List?, String?, String?)? onChanged;

  CustomImagePicker({
    super.key,
    this.imageBytes,
    required this.labelText,
    this.onChanged,
  });

  @override
  CustomImagePickerState createState() => CustomImagePickerState();
}

class CustomImagePickerState extends State<CustomImagePicker> {
  String? _errorMessage;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _requestPermissions() async {
    if (kIsWeb) return;

    if (Platform.isAndroid || Platform.isIOS) {
      Map<Permission, PermissionStatus> status = await [
        Permission.camera,
        Permission.photos,
      ].request();

      bool isPermissionDenied =
          status[Permission.camera] != PermissionStatus.granted ||
              status[Permission.photos] != PermissionStatus.granted;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          isPermissionDenied = isPermissionDenied ||
              status[Permission.storage] != PermissionStatus.granted;
        }
      }

      if (isPermissionDenied) {
        setState(() {
          _errorMessage = 'Permission denied';
        });
      }
    }
  }

  Future<void> _showImageSourceSelector(BuildContext context) async {
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
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureImageFromCamera() async {
    List<CameraDescription> cameras =
        await CameraPlatform.instance.availableCameras();
    if (cameras.isNotEmpty) {
      final CameraDescription camera = cameras.first;
      final int cameraId = await CameraPlatform.instance
          .createCamera(camera, ResolutionPreset.high);

      await CameraPlatform.instance.initializeCamera(cameraId);
      final XFile file = await CameraPlatform.instance.takePicture(cameraId);

      Uint8List bytes = await file.readAsBytes();
      String? fileName = file.name;
      String? fileType = file.mimeType ?? 'image/jpeg';

      setState(() {
        widget.imageBytes = bytes;
      });
      widget.onChanged?.call(bytes, fileName, fileType);

      await CameraPlatform.instance.dispose(cameraId);
    } else {
      print('No available cameras');
    }
  }

  Future<void> _getDesktopImage(
      ImageSource source, BuildContext context) async {
    if (source == ImageSource.camera) {
      await _captureImageFromCamera();
    } else if (source == ImageSource.gallery) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        Uint8List? bytes = kIsWeb
            ? result.files.single.bytes
            : await File(result.files.single.path!).readAsBytes();
        String? fileName = result.files.single.name;
        String? fileType = result.files.single.extension;

        if (bytes != null) {
          setState(() {
            widget.imageBytes = bytes;
          });
          widget.onChanged?.call(bytes, fileName, fileType);
        }
      } else {
        print('No file selected.');
      }
    }
  }

  Future<void> _getImage(ImageSource source) async {
    if (_isDesktop()) {
      await _getDesktopImage(source, context);
    } else {
      await _getMobileImage(source);
    }
  }

  Future<void> _getMobileImage(ImageSource source) async {
    await _requestPermissions();

    final picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: source, imageQuality: 50);
      if (pickedFile != null) {
        // Check the file size
        bool isValidSize = await _checkImageSize(pickedFile.path);

        if (isValidSize) {
          Uint8List bytes = await pickedFile.readAsBytes();
          String? fileName = pickedFile.name;
          String? fileType = pickedFile.mimeType ?? 'image/jpeg';

          setState(() {
            widget.imageBytes = bytes;
            _errorMessage = null;
          });
          _errorMessage = '';

          widget.onChanged?.call(bytes, fileName, fileType);
        } else {
          // Show error message if file size is larger than 1MB
          setState(() {
            _errorMessage = 'Image size should be less than 1MB';
            widget.imageBytes = null;
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<bool> _checkImageSize(String filePath) async {
    File file = File(filePath);
    int fileSize = await file.length();
    return fileSize <= 1024 * 1024; // 1 MB = 1024 * 1024 bytes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.imageBytes != null
            ? Center(
                child: SizedBox(
                  height: 100.0,
                  width: 200.0,
                  child: Image.memory(widget.imageBytes!),
                ),
              )
            : const Text('No image selected.'),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => _showImageSourceSelector(context),
          icon: const Icon(Icons.image),
          label: Text(widget.labelText),
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  bool _isDesktop() {
    return !kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
  }
}
