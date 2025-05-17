import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suitmedia_task/model/userModel.dart';

class ApiService {
  static const String baseUrl = "https://reqres.in/api/users";

  Future<UserResponseModel> fetchUsers({int page = 1, int perPage = 10}) async {
    final url = '$baseUrl?page=$page&per_page=$perPage';
    print("Fetching from: $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {"x-api-key": "reqres-free-v1"},
    );
    // print("Status Code: ${response.statusCode}");
    // print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserResponseModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load users");
    }
  }
}
