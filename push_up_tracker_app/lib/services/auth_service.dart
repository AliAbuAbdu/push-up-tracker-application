import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('token', data['token']);
      return data;
    }

    throw Exception(data['message'] ?? 'Login failed');
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    if (token == null) {
      throw Exception('No login token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data['user'];
    }

    throw Exception(data['error'] ?? 'Could not load user');
  }
}