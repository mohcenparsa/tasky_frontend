// image_upload_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class ImageUploadService {
  static Future<String?> uploadImage(
    Uint8List bytes,
    String fileName,
  ) async {
    String mimeType = fileName!.endsWith('png') ? 'image/png' : 'image/jpeg';

    final uri = Uri.parse('https://todo.iraqsapp.com/upload/image');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ));
    request.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        return responseJson[
            'image']; // Assuming the URL is in the 'image' field
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Upload failed: ${response.statusCode}');
        print('Server response: $responseBody');
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }
}
