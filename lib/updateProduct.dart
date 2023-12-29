import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatefulWidget {
  final int productId;

  EditProduct(this.productId);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  // Fetch product details from the server based on the productId
  Future<void> fetchProductDetails() async {
    final String apiUrl = 'http://techprostore.000webhostapp.com/searchP.php?Id=${widget.productId}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        for (var row in jsonResponse) {
          nameController.text = row['name'];
          descriptionController.text = row['description'];
          quantityController.text = row['quantity'].toString();
          priceController.text = row['price'].toString();
          imageController.text = row['img'];

        }
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch product details'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching product details: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Update product details on the server
  Future<void> updateProduct() async {
    int id = widget.productId;
    final String apiUrl = 'http://techprostore.000webhostapp.com/updateProduct.php?pid=$id';

    final Map<String, dynamic> productData = {
      'name': nameController.text,
      'quantity': int.parse(quantityController.text),
      'price': int.parse(priceController.text),
      'description': descriptionController.text,
      'image': imageController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}, // Set content type to JSON
        body: jsonEncode(productData), // Encode data as JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);

        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating product: ${result['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update product. Server returned ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating product: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    // Fetch product details when the widget is initialized
    fetchProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Product ID: ${widget.productId}'),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),

              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProduct,
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      )


    );
  }
}
