import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/src/models/profile.dart';

class ProfileService {
  static String baseUrl = 'https://todo.iraqsapp.com/auth/profile';

  static Future<Profile> getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final response = await http
          .get(Uri.parse(baseUrl), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Profile.fromJson(data);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}
