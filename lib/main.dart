import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_task/pages/first_page.dart';
import 'package:suitmedia_task/service/userProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Userprovider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Suitmedia Task",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MyFirstPage(),
    );
  }
}
