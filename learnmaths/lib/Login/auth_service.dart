import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class AuthService {
  Future<http.Response> login({required String mobile, required String password, required String deviceId}) async {
    final response = await http.post(
      Uri.parse('${Config.apiBaseUrl}/api/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Mobile': mobile, 'Password': password, 'DeviceId': deviceId}),
    );
    return response;
  }
}
