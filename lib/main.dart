import 'package:flutter/material.dart';
import 'homepage.dart';
import 'loadingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NavBar(), // Use the new name here
    );
  }
}
