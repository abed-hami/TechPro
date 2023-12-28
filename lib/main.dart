import 'package:flutter/material.dart';
import 'package:techprostore/productlist.dart';
import 'package:techprostore/showproduct.dart';
import 'adminproducts.dart';
import 'home.dart';
import 'homepage.dart';
import 'loadingpage.dart';
import 'productlist.dart';
import 'login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TechPro',
      home: Scaffold(
        body: Loading()
      ), // Use the new name here
    );
  }
}
