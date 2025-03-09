import 'package:flutter/material.dart';
import 'package:suitmedia_task/model/userModel.dart';
import 'package:suitmedia_task/service/ApiService.dart';
import 'package:suitmedia_task/widget/customeButton.dart';

class MyThirdPage extends StatefulWidget {
  @override
  _MyThirdPageState createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<UserModel> users = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  String selectedUserName = "None";

  int change_perPage = 4;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers({int page = 1}) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final response = await apiService.fetchUsers(
        page: page,
        perPage: change_perPage,
      );
      setState(() {
        users = response.users;
        currentPage = response.page;
        totalPages = response.totalPages;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }

    setState(() => isLoading = false);
  }

  Future<void> refreshUsers() async {
    await fetchUsers(page: currentPage);
  }

  void _nextPage() {
    if (currentPage < totalPages) {
      fetchUsers(page: currentPage + 1);
    }
  }

  void _prevPage() {
    if (currentPage > 1) {
      fetchUsers(page: currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Users per Page: ", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: change_perPage,
                  items:
                      [4, 6, 8, 10].map((value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text("$value"),
                        );
                      }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        change_perPage = newValue;
                        currentPage = 1;
                        fetchUsers();
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Selected User: $selectedUserName",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshUsers,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                        radius: 30,
                      ),
                      title: Text(
                        "${user.firstName} ${user.lastName}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(user.email),
                      onTap: () {
                        setState(() {
                          selectedUserName =
                              "${user.firstName} ${user.lastName}";
                          Navigator.pop(context, user);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: "Previous",
                  onPressed: currentPage > 1 ? _prevPage : null,
                ),
                SizedBox(width: 20),
                Text("Page $currentPage of $totalPages"),
                SizedBox(width: 20),
                CustomButton(
                  title: "Next",
                  onPressed: currentPage < totalPages ? _nextPage : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
