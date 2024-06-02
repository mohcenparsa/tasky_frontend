import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static const String baseUrl = 'https://wonder.pockethost.io';

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to log in');
    }
  }

  static Future<Map<String, dynamic>> register(String email, String password,
      String name, String phone, String experience) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'experience': experience,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
  }
}

String dateString(DateTime? dueDate) {
  if (dueDate == null) {
    return ""; // Handle the case where dueDate is null
  }
  final formatter = DateFormat('yyyy-MM-dd'); // Format as "yyyy-MM-dd"
  final formattedDate = formatter.format(dueDate);
  return formattedDate;
}
