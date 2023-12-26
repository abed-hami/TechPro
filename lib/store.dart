import 'package:flutter/material.dart';
import 'package:techprostore/homepage.dart';
import 'home.dart';
import 'productlist.dart';
class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Home()
    );
  }
}
