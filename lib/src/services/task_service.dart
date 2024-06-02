import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/src/services/auth_service.dart';
import 'package:tasky/src/utils/ai_helper.dart';
import '../models/task_item.dart';

class TaskService {
  static String baseUrl = 'https://todo.iraqsapp.com/todos';
  static Future<List<TaskItem>> getTasks() async {
    try {
      final token = await AuthService.getAccessToken();
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<TaskItem> tasks =
            data.map((item) => TaskItem.fromJson(item)).toList();
        return tasks;
      } else if (response.statusCode == 401) {
        print("Not authroized.....");
        // If access token is expired, refresh it and retry the request
        var newToken = await AuthService.refreshToken();
        print('new token');
        final retryResponse = await http.get(
          Uri.parse(baseUrl),
          headers: {'Authorization': 'Bearer $newToken'},
        );

        if (retryResponse.statusCode == 200) {
          List<dynamic> data = json.decode(retryResponse.body);
          List<TaskItem> tasks =
              data.map((item) => TaskItem.fromJson(item)).toList();
          return tasks;
        } else {
          throw Exception('Failed to load tasks after refreshing token');
        }
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  static Future<bool> createTask({
    required String title,
    required String desc,
    required String priority,
    String? image, // Optional parameter for image URL
    DateTime? dueDate, // Optional parameter for due date
  }) async {
    final uri = Uri.parse('https://todo.iraqsapp.com/todos');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority,
        'dueDate': dateString(dueDate),
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateTask({
    required String id,
    required String title,
    required String desc,
    required String priority,
    String? image, // Optional parameter for image URL
    DateTime? dueDate,
  }) async {
    try {
      final uri = Uri.parse('https://todo.iraqsapp.com/todos/$id');
      print('uri: $uri');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'image': image,
          'title': title,
          'desc': desc,
          'priority': priority,
          'dueDate': dateString(dueDate),
        }),
      );

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<TaskItem?> getTaskById(String id) async {
    final uri = Uri.parse('https://todo.iraqsapp.com/todos/$id');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return TaskItem.fromJson(data);
    } else {
      return null;
    }
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final url = Uri.parse('$baseUrl/$taskId'); // Construct URL with task ID

      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
