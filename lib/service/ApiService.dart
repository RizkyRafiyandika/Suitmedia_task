import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suitmedia_task/model/userModel.dart';

class ApiService {
  static const String baseUrl = "https://reqres.in/api/users";

  Future<UserResponseModel> fetchUsers({int page = 1, int perPage = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?page=$page&per_page=$perPage'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserResponseModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load users");
    }
  }
}
