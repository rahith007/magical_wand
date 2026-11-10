import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl = 'https://notepad-backend-ed6x.onrender.com';

  Future<Map<String, dynamic>> registerApi({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required int contactNumber,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/auth/singup'),
        body: {
          'fullName': fullName,
          'userName': userName,
          'email': email,
          'contactNumber': contactNumber,
          'password': password,
        },
      );
      final output = jsonDecode(res.body);
      await FlutterSecureStorage().write(
        key: 'authToken',
        value: output['token'],
      );
      return output;
    } catch (e) {
      debugPrint('error while signUp:$e');
    }
  }

  Future<Map<String, dynamic>> loginApi({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        body: {'email': email, 'password': password},
      );
      final output = jsonDecode(res.body);
      await FlutterSecureStorage().write(
        key: 'authToken',
        value: output['token'],
      );
      return output;
    } catch (e) {
      debugPrint('error while login:$e');
    }
  }
}
