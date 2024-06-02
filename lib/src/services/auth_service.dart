import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/config/app_config.dart';

class AuthService {
  static String baseUrl = AppConfig.baseUrl;

  static Future<bool> register(
      {required String? phone,
      required String password,
      required String displayName,
      required String experienceYears,
      required String address,
      required String level}) async {
    try {
      final url = Uri.parse('$baseUrl/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "displayName": displayName,
          "experienceYears": experienceYears,
          "level": level
        }),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final token = body['access_token'];
        final refreshToken = body['refresh_token'];
        await saveTokens(token, refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> login(String mobile, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        // body: jsonEncode({'phone': "+93786203320", 'password': "Test@1234"}),
        body: jsonEncode({'phone': mobile, 'password': password}),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final accessToken = body['access_token'];
        final refreshToken = body['refresh_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final token = prefs.getString('access_token');
      if (token == null) return false;

      return true;
      // final url = Uri.parse('$baseUrl/auth/validate-token');
      // try {
      //   final response = await http.get(
      //     url,
      //     headers: {'x-auth-token': token},
      //   );

      //   if (response.statusCode == 200) {
      //     final body = jsonDecode(response.body);
      //     return body['valid'];
      //   } else {
      //     return false;
      //   }
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Future<void> profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  Future<http.Response> _sendAuthorizedRequest(
      Future<http.Response> Function() requestFunction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('No access token found');
    }

    var response = await requestFunction();

    if (response.statusCode == 401) {
      final newToken = await refreshToken();
      if (newToken != "") {
        response = await requestFunction();
      }
    }
    return response;
  }

  Future<http.Response> getData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await _sendAuthorizedRequest(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      return await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
    });
  }

  Future<http.Response> postData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await _sendAuthorizedRequest(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      return await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data),
      );
    });
  }

  Future<http.Response> deleteData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await _sendAuthorizedRequest(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      return await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
    });
  }

  Future<http.Response> editData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await _sendAuthorizedRequest(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      return await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data),
      );
    });
  }

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    return token;
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('refresh_token');
    return token;
  }

  static Future<String> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return "";

    final response = await http.get(
      Uri.parse(
          'https://todo.iraqsapp.com/auth/refresh-token?token=$refreshToken'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveTokens(data['access_token'], refreshToken);
      return data['access_token'];
    } else {
      return "";
    }
  }
}
