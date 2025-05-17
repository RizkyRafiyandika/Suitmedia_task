import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_task/service/userProvider.dart';
import 'package:suitmedia_task/widget/customeButton.dart';

class MyThirdPage extends StatefulWidget {
  @override
  _MyThirdPageState createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
  final ScrollController _scrollController = ScrollController();

  // List<UserModel> users = [];
  // int currentPage = 1;
  // int totalPages = 1;
  // bool isLoading = false;
  // String selectedUserName = "None";
  // int change_perPage = 4;

  // // Options for items per page
  final List<int> perPageOptions = [4, 6, 8, 10];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Userprovider>(context, listen: false).fetchUsers();
    });
  }

  // Future<void> fetchUsers({int page = 1}) async {
  //   if (isLoading) return;

  //   setState(() => isLoading = true);

  //   try {
  //     final response = await apiService.fetchUsers(
  //       page: page,
  //       perPage: change_perPage,
  //     );
  //     setState(() {
  //       users = response.users;
  //       currentPage = response.page;
  //       totalPages = response.totalPages;
  //     });
  //   } catch (e) {
  //     print("Error fetching users: $e");
  //   }

  //   setState(() => isLoading = false);
  // }

  // Future<void> refreshUsers() async {
  //   await fetchUsers(page: currentPage);
  // }

  // void _nextPage() {
  //   if (currentPage < totalPages) {
  //     fetchUsers(page: currentPage + 1);
  //   }
  // }

  // void _prevPage() {
  //   if (currentPage > 1) {
  //     fetchUsers(page: currentPage - 1);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: Consumer<Userprovider>(
        builder: (context, userProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Users per Page: ", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      value: userProvider.perPage,
                      items:
                          perPageOptions.map((value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text("$value"),
                            );
                          }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          userProvider.setPerPage(newValue);
                          userProvider.fetchUsers();
                        }
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Selected User: ${userProvider.selectedUser?.firstName} ${userProvider.selectedUser?.lastName ?? "None"}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh:
                      () => userProvider.fetchUsers(
                        page: userProvider.currentPage,
                      ),
                  child:
                      userProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            controller: _scrollController,
                            itemCount: userProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = userProvider.users[index];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
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
                                    userProvider.setSelectedUser(user);
                                    Navigator.pop(context);
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
                      onPressed:
                          userProvider.currentPage > 1
                              ? userProvider.prevPage
                              : null,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Page ${userProvider.currentPage} of ${userProvider.totalPages}",
                    ),
                    SizedBox(width: 20),
                    CustomButton(
                      title: "Next",
                      onPressed:
                          userProvider.currentPage < userProvider.totalPages
                              ? userProvider.nextPage
                              : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
