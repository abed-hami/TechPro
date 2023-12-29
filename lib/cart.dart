import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techprostore/userlogin.dart';

import 'cartProduct.dart';

class CartDisplay extends StatefulWidget {
  const CartDisplay({Key? key}) : super(key: key);

  @override
  State<CartDisplay> createState() => _CartDisplayState();
}

class _CartDisplayState extends State<CartDisplay> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartproducts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      "${cartproducts[index].name}",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "\$${cartproducts[index].price} x ${(cartproducts[index].total ~/ cartproducts[index].price)}",

                      style: TextStyle(fontSize: 16.0),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _showSnackBar("Product removed");
                          cartproducts.remove(cartproducts[index]);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Total amount and Confirm button
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Total: \$${calculateTotalAmount()}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) =>  LoginScreen()));

                  },
                  child: Text("Confirm Order"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to calculate the total amount
  String calculateTotalAmount() {
    double total = 0;
    for (var product in cartproducts) {
      total += product.price * (product.total/product.price);
    }
    return total.toStringAsFixed(2);
  }
}
