import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// domain of your server
const String _baseURL = 'https://techprostore.000webhostapp.com';
// used to retrieve the key later
EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _controllerQuantity = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();
  int? selectedValue;
  bool _loading = false;

  @override
  void dispose() {
    _controllerQuantity.dispose();
    _controllerName.dispose();
    _controllerPrice.dispose();
    _controllerDescription.dispose();
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
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
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerDescription,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                ),
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
                  ),
                ),
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
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerImage,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Image URL',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter image URL';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<int>(
                    value: selectedValue,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Laptops'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('Phones'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('Accessories'),
                      ),
                      DropdownMenuItem<int>(
                        value: 4,
                        child: Text('Monitors and PC'),
                      ),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Category',
                    ),
                    validator: (int? value) {
                      if (value == null) {
                        return 'Please select a Category';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                          });
                          saveCategory(
                            update,
                            _controllerName.text.toString(),
                            int.parse(_controllerQuantity.text),
                            int.parse(_controllerPrice.text),
                            _controllerDescription.text.toString(),
                            selectedValue!,
                            _controllerImage.text.toString(),
                          );
                        },
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _loading,
                  child: const CircularProgressIndicator(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void saveCategory(
  Function(String text) update,
  String name,
  int quantity,
  int price,
  String description,
  int category,
  String image,
) async {
  try {
    final response = await http
        .post(
          Uri.parse('$_baseURL/save.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode({
            'name': name,
            'quantity': quantity,
            'price': price,
            'description': description,
            'category': category,
            'image': image,
          }),
        )
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      update(response.body);
    }
  } catch (e) {
    update("connection error");
  }
}
