import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techprostore/productdetails.dart';
import 'package:techprostore/singleProduct.dart';

const String _baseURL = 'techprostore.000webhostapp.com';

class Product {
  int pid;
  String name;
  String description;
  int quantity;
  double price;
  String category;
  String img;

  Product({
    required this.pid,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.img,
    required this.category,
  });

  @override
  String toString() {
    return 'PID: $pid Name: $name Quantity: $quantity Price: \$$price Category: $category';
  }
}

List<Product> productItems = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 50));

    productItems.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      for (var row in jsonResponse) {
        Product p = Product(
          pid: int.parse(row['pid']),
          name: row['name'],
          description: row['description'],
          quantity: int.parse(row['quantity']),
          price: double.parse(row['price']),
          img: row['img'],
          category: row['category'],
        );
        productItems.add(p);
      }

      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void deleteProduct(Function(bool success, String message) callback, int pid) async {
  try {
    final url = Uri.https(_baseURL, 'deleteProduct.php', {'pid': '$pid'});
    final response = await http.delete(url).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['success']) {
        callback(true, jsonResponse['message']);
      } else {
        callback(false, jsonResponse['message']);
      }
    }
  } catch (e) {
    callback(false, "Error: $e");
  }
}


void searchProduct(Function(String text) update, int pid) async {
  try {
    final url = Uri.https(_baseURL, 'searchProduct.php', {'pid': '$pid'});
    final response = await http.get(url).timeout(const Duration(seconds: 30));

    productItems.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse.isNotEmpty) {
        var row = jsonResponse[0];
        Product p = Product(
          pid: int.parse(row['pid']),
          name: row['name'],
          description: row['description'],
          quantity: int.parse(row['quantity']),
          price: double.parse(row['price']),
          img: row['img'],
          category: row['category'],
        );
        productItems.add(p);
        update(p.toString());
      }
    }
  } catch (e) {
    update("Can't load data");
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (productItems.length / 3).ceil(),
      itemBuilder: (context, index) {
        int startIndex = index * 2;
        int endIndex = (index + 1) * 2;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              if (startIndex < productItems.length)
                Expanded(child: ProductCard(product: productItems[startIndex])),
              SizedBox(width: 8.0),
              if (endIndex < productItems.length)
                Expanded(child: ProductCard(product: productItems[endIndex])),
            ],
          ),
        );
      },
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                image: DecorationImage(
                  image: AssetImage(product.img), // Replace with appropriate image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProductDetails(),
            settings: RouteSettings(
              arguments: ProductD(
                product.pid,
                product.name,
                product.description,
                product.quantity,
                product.price,
                product.img,
                product.category,
              ),
            ),
          ),
        );
      },
    );
  }
}



