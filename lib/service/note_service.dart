import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:magical_wand/models/note_details_model.dart';
import 'package:magical_wand/models/note_model.dart';

class NoteService {
  static const String baseUrl = 'https://notepad-backend-ed6x.onrender.com';

  Future<Map<String, dynamic>> insertNote({

    required String title,
    required String content,
    required String tags,
  }) async {
    final List<String> listTags=tags.split(',');
    final token=await FlutterSecureStorage().read(key:'authToken');
    final response = await http.post(
      Uri.parse("$baseUrl/notepad-insert"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"title": title, "content": content,"tags":listTags}),
    );

    return jsonDecode(response.body);
  }

  Future<List<NotepadResponseModel>> getNotes() async {
    final token = await FlutterSecureStorage().read(key: 'authToken');
    final response = await http.get(
      Uri.parse("$baseUrl/notepad-notes"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    Map<String, dynamic> resJson = jsonDecode(response.body);
    List<dynamic> data = resJson['data'];
    List<NotepadResponseModel> output = data
        .map((e) => NotepadResponseModel.fromJson(e))
        .toList();
    return output;
  }

  Future<Map<String, dynamic>> updateNote({
    required String token,
    required String noteId,
    required String title,
    required String content,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update-notepad/:noteId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"title": title, "content": content}),
    );

    return jsonDecode(response.body);
  }

  Future<String> deleteNote({required String noteId}) async {
    final token = await FlutterSecureStorage().read(key: 'authToken');
    final response = await http.delete(
      Uri.parse("$baseUrl/erase/$noteId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final schema = jsonDecode(response.body);
    return schema['message'];
  }

  Future<DetailsModel> getNotePadDetails({required String id}) async {
    final response = await http.get(Uri.parse('$baseUrl/details-notes/$id'));
    final schema = jsonDecode(response.body);
    return schema['data'];
  }

  Future<String> pinOrUnpinNotepad({required String noteId}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/pin-or-unpin"),
      body: {'noteId': noteId},
    );
    final schema = jsonDecode(response.body);
    return schema['message'];
  }

  
}
