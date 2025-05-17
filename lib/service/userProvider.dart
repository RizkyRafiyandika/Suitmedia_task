import 'package:flutter/material.dart';
import 'package:suitmedia_task/model/userModel.dart';
import 'package:suitmedia_task/service/ApiService.dart';

class Userprovider with ChangeNotifier {
  String name = "None";

  String get username => name;

  void setUserName(String? newName) {
    if (newName == null || newName.isEmpty) {
      name = "None";
    } else {
      name = newName;
    }
    notifyListeners();
  }

  String _selectedUserName = "None";

  String get selectedUserName => _selectedUserName;

  void setSelectedUserName(String name) {
    _selectedUserName = name;
    notifyListeners();
  }

  final ApiService _apiService = ApiService();

  List<UserModel> _users = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  int _perPage = 4;

  UserModel? _selectedUser;

  List<UserModel> get users => _users;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLoading => _isLoading;
  int get perPage => _perPage;
  UserModel? get selectedUser => _selectedUser;

  Future<void> fetchUsers({int page = 1}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.fetchUsers(
        page: page,
        perPage: _perPage,
      );
      _users = response.users;
      _currentPage = response.page;
      _totalPages = response.totalPages;
    } catch (e) {
      print("Error fetching users: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void setPerPage(int value) {
    _perPage = value;
    _currentPage = 1;
    fetchUsers();
  }

  void nextPage() {
    if (_currentPage < _totalPages) {
      fetchUsers(page: _currentPage + 1);
    }
  }

  void prevPage() {
    if (_currentPage > 1) {
      fetchUsers(page: _currentPage - 1);
    }
  }

  void setSelectedUser(UserModel user) {
    _selectedUser = user;
    _selectedUserName = "${user.firstName} ${user.lastName}";
    notifyListeners();
  }

  void clearSelectedUser() {
    _selectedUser = null;
    notifyListeners();
  }
}
