import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learnmaths/config.dart';
import 'package:learnmaths/device_service.dart';

class MobileAlreadyRegisteredException implements Exception {
  final String message;
  MobileAlreadyRegisteredException([this.message = 'Mobile number already registered.']);
  @override
  String toString() => message;
}

class RegisterController extends ChangeNotifier {
  final usernameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _deviceId;
  String? get deviceId => _deviceId;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> getDeviceId() async {
    _isLoading = true;
    notifyListeners();
    try {
      _deviceId = await DeviceService.getDeviceId();
    } catch (e) {
      _deviceId = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> registerUser() async {
    _isLoading = true;
    notifyListeners();
    try {
      await getDeviceId();
      final response = await http.post(
        Uri.parse('${Config.apiBaseUrl}/api/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Phone': mobileController.text,
          'Name': usernameController.text,
          'Password': passwordController.text,
          'deviceid': _deviceId ?? '',
        }),
      );
      _isLoading = false;
      notifyListeners();
      if (response.statusCode == 409) {
        throw MobileAlreadyRegisteredException();
      }
      return response.statusCode == 200;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e is MobileAlreadyRegisteredException) {
        rethrow;
      }
      return false;
    }
  }

  void disposeControllers() {
    usernameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
