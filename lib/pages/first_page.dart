import 'package:flutter/material.dart';
import 'package:suitmedia_task/pages/second_page.dart';
import 'package:suitmedia_task/widget/customeButton.dart';
import 'package:suitmedia_task/widget/customeTextField.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({super.key});

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  bool isPalindrome(String text) {
    String processedText =
        text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return processedText == processedText.split('').reversed.join('');
  }

  void _checkPalindrome() {
    String text = _palindromeController.text;
    bool result = isPalindrome(text);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(result ? "isPalindrome" : "not palindrome"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MySecondPage(name: _nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            CustomTextField(
              label: "Name",
              hintText: "Enter your name",
              controller: _nameController,
            ),
            SizedBox(height: 20),
            CustomTextField(
              label: "Palindrome",
              hintText: "Enter text to check",
              controller: _palindromeController,
            ),
            SizedBox(height: 20),
            CustomButton(title: "Polindrome", onPressed: _checkPalindrome),
            SizedBox(height: 10),
            CustomButton(title: "Name", onPressed: _goToNextScreen),
          ],
        ),
      ),
    );
  }
}
