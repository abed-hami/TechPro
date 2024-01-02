import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'admin_addproduct.dart';
import 'adminproducts.dart';
EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();
class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(actions: [
        IconButton(onPressed: () {
          _encryptedData.remove('admin').then((success) =>
              Navigator.of(context).pop());
        }, icon: const Icon(Icons.logout))
      ],
        title: const Text('Admin Page'),
        centerTitle: true,
        // the below line disables the back button on the AppBar
        automaticallyImplyLeading: false,
      ),
        body:
        Column(
              children:[
                SizedBox(height:40),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AdminProduct()
                        )
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "View/Delete Product",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                  ),
                ),
                SizedBox(height:20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => AddCategory()
                        )
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                  ),
                ),
              ]
          )
        );

  }
}
