import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// domain of your server
const String _baseURL = 'https://techprostore.000webhostapp.com';
// used to retrieve the key later
EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  // creates a unique key to be used by the form
  // this key is necessary for validation

  TextEditingController _controllerQuantity = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  // the below variable is used to display the progress bar when retrieving data
  bool _loading = false;

  @override
  void dispose() {
    _controllerQuantity.dispose();
    _controllerName.dispose();
    _controllerPrice.dispose();
    _controllerDescription.dispose();
    _controllerCategory.dispose();
    _controllerImage.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
          // the below line disables the back button on the AppBar
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Form(
          // key to uniquely identify the form when performing validation
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerDescription,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter  Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerPrice,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Price',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerQuantity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Quantity',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerImage,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Image url',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter image';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerCategory,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Category',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Category';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading
                    ? null
                    : () {
                        // disable button while loading

                        setState(() {
                          _loading = true;
                        });
                        saveCategory(
                          update,
                          _controllerName.text.toString(),
                          int.parse(_controllerQuantity.text),
                          int.parse(_controllerPrice.text),
                          _controllerDescription.text.toString(),
                          int.parse(_controllerCategory.text),
                          _controllerImage.text.toString(),

                        );

                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              Visibility(
                  visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        ))));
  }
}

// below function sends the cid, name and key using http post to the REST service
void saveCategory(Function(String text) update, String name, int quantity, int price, String description, int category, String image) async {
  try {
    // we need to first retrieve and decrypt the key

    // send a JSON object using http post
    final response = await http
        .post(Uri.parse('$_baseURL/save.php'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            }, // convert the cid, name and key to a JSON object
      body: convert.jsonEncode({
        'name': name,
        'quantity': quantity,
        'price': price,
        'description': description,
        'category': category,
        'image': image,


      }),
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful, call the update function
      update(response.body);
    }
  } catch (e) {
    update("connection error");
  }
}
