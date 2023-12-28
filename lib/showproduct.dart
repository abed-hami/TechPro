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


class ShowProducts extends StatelessWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: productItems.length,
      itemBuilder: (context, index) {
        return ProductCard(product: productItems[index]);
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
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: product.img.isNotEmpty
                    ? Image.network(
                  product.img,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text('Image Load Failed'),
                    );
                  },
                )
                    : Center(
                  child: Text('Image URL is empty'),
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
    );
  }
}







