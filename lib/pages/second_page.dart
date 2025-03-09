import 'package:flutter/material.dart';
import 'package:suitmedia_task/model/userModel.dart';
import 'package:suitmedia_task/pages/third_page.dart';
import 'package:suitmedia_task/widget/customeButton.dart';

class MySecondPage extends StatefulWidget {
  final String name;

  const MySecondPage({super.key, required this.name});

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  String selectedUserName = "None";

  @override
  Widget build(BuildContext context) {
    void _ChooseButton() async {
      final UserModel? selectedUser = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyThirdPage()),
      );
      if (selectedUser != null) {
        setState(() {
          selectedUserName =
              "${selectedUser.firstName} ${selectedUser.lastName}";
        });
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
            Text("Name: ${widget.name}", style: TextStyle(fontSize: 18)),
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
