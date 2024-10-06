import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/user.dart';

class ApiService {
  static const String _baseUrl = 'https://randomuser.me/api/';
  static const int _userPerPage = 20;

  Future<List<User>> fetchUsers(int page) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?results=$_userPerPage&page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List users = data['results'];
      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
