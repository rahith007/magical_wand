import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magical_wand/models/profile_model.dart';

class ProfileService {
  static const String baseUrl = 'https://notepad-backend-ed6x.onrender.com';

  Future<ProfileModel> getProfile() async {
    final token=await FlutterSecureStorage().read(key: 'authToken');
    final response = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String fullName,
    required String userName,
    required String email,
    required String contactNumber,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "contactNumber": contactNumber,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/change-password"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      }),
    );

    return jsonDecode(response.body);
  }
}