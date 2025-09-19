import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class AuthService {
  Future<http.Response> login({required String email, required String password, required String deviceId}) async {
    final response = await http.post(
      Uri.parse('${Config.apiBaseUrl}/api/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Email': email, 'Password': password, 'DeviceId': deviceId}),
    );
    return response;
  }
}
