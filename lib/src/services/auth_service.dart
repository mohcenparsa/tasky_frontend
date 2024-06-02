import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/config/app_config.dart';
import 'package:jwt_decode/jwt_decode.dart'; // Import the package for decoding JWT tokens

class AuthService {
  static String baseUrl = AppConfig.baseUrl;

  static Future<bool> register({
    required String? phone,
    required String password,
    required String displayName,
    required String experienceYears,
    required String address,
    required String level,
  }) async {
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
    print(
      'trying to login',
    );
    print(mobile);
    print(password);
    final url = Uri.parse('${AppConfig.baseUrl}/auth/login');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': mobile, 'password': password}),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final accessToken = body['access_token'];
        final refreshToken = body['refresh_token'];
        await saveTokens(accessToken, refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    print('loging out');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Future<void> profile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  static Future<bool> saveTokens(
    String accessToken,
    String refreshToken,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    return true;
  }

  static Future<bool> isLoggedIn() async {
    // 1. Retrieve the access token from secure storage
    String? accessToken = await getCurrentAccessToken();

    if (accessToken == null) {
      return false;
    }

    // 3. Decode the access token
    Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);

    // 4. Compare the expiration time with the current time
    int? expiryTime =
        decodedToken['exp']; // Expiration time in seconds since epoch
    int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (expiryTime != null && expiryTime > currentTimeInSeconds) {
      // Token is not expired
      return true; // User is logged in
    } else {
      await logout();
      // Token is expired
      // Optionally, you can clear the expired token here
      // await SecureStorage.clearAccessToken();
      return false; // User is not logged in
    }
    // try {
    //   final currentAccessToken = await getCurrentAccessToken();
    //   if (currentAccessToken == null || currentAccessToken == '') return false;
    //   await storeNewRefreshToken();
    //   return true;
    // } catch (e) {
    //   return false;
    // }
  }

  static Future<String> storeNewRefreshToken() async {
    final currentRefreshToken = await getCurrentRefreshToken();
    if (currentRefreshToken == null) return "";

    final uri = '${AppConfig.refreshTokenApi}token=$currentRefreshToken';
    final response = await http.get(
      Uri.parse(uri),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newToken = data["access_token"];
      await saveTokens(newToken, currentRefreshToken);
      return newToken;
    } else {
      return "";
    }
  }

  static Future<String?> getCurrentAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<String?> getCurrentRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }
}
