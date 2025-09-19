import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learnmaths/config.dart';
import 'package:learnmaths/device_service.dart';

class EmailAlreadyRegisteredException implements Exception {
  final String message;
  EmailAlreadyRegisteredException([this.message = 'Email already registered.']);
  @override
  String toString() => message;
}

class RegisterController extends ChangeNotifier {
  final usernameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  
  RegisterController() {
    // Rebuild listeners when any field changes so UI can enable/disable the button reactively
    usernameController.addListener(_onFieldsChanged);
    mobileController.addListener(_onFieldsChanged);
    passwordController.addListener(_onFieldsChanged);
    emailController.addListener(_onFieldsChanged);
  }

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

  void _onFieldsChanged() {
    // Notify listeners so widgets depending on controller values rebuild
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
          'Email': emailController.text,
          'Password': passwordController.text,
          'deviceid': _deviceId ?? '',
        }),
      );
      _isLoading = false;
      notifyListeners();
      if (response.statusCode == 409) {
        throw EmailAlreadyRegisteredException();
      }
      return response.statusCode == 200;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e is EmailAlreadyRegisteredException) {
        rethrow;
      }
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.removeListener(_onFieldsChanged);
    mobileController.removeListener(_onFieldsChanged);
    passwordController.removeListener(_onFieldsChanged);
    emailController.removeListener(_onFieldsChanged);

    usernameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
