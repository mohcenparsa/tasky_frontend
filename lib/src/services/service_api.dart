import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/config/app_config.dart';
import 'package:tasky/src/services/auth_service.dart';

class ServiceApi {
  Future<http.Response> getData(String endpoint) async {
    final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
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
    final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
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

  Future<http.Response> editData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
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

  Future<http.Response> _sendAuthorizedRequest(
      Future<http.Response> Function() requestFunction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('No access token found');
    }

    var response = await requestFunction();

    if (response.statusCode == 401) {
      final newToken = await AuthService.storeNewRefreshToken();
      if (newToken != "") {
        response = await requestFunction();
      }
    }
    return response;
  }

  Future<http.Response> deleteData(String endpoint) async {
    final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
    return await _sendAuthorizedRequest(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      return await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
    });
  }
}
