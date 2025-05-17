import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_task/model/userModel.dart';
import 'package:suitmedia_task/pages/third_page.dart';
import 'package:suitmedia_task/service/userProvider.dart';
import 'package:suitmedia_task/widget/customeButton.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key});

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userprovider>(context);
    final String name = userProvider.username;
    final String selectedUserName = userProvider.selectedUserName;

    void _ChooseButton() async {
      final UserModel? selectedUser = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyThirdPage()),
      );
      if (selectedUser != null) {
        userProvider.setSelectedUserName(
          "${selectedUser.firstName} ${selectedUser.lastName}",
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Name: ${name}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              "Selected User: ${selectedUserName}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CustomButton(title: "Choose a User", onPressed: _ChooseButton),
          ],
        ),
      ),
    );
  }
}
