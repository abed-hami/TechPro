import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// main URL for REST pages
const String _baseURL = 'techprostore.000webhostapp.com';

// class to represent a row from the products table
// note: cid is replaced by category name
class Product {
  int _pid;
  String _name;
  int _quantity;
  double _price;
  String _category;
  String img;

  Product(this._pid, this._name, this._quantity, this._price,this.img, this._category);

  @override
  String toString() {
    return 'PID: $_pid Name: $_name Quantity: $_quantity Price: \$$_price Category: $_category';
  }
}
// list to hold products retrieved from getProducts
List<Product> productitems = [];
// asynchronously update _products list
void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 50)); // max timeout 5 seconds
    productitems.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        Product p = Product( // create a product object from JSON row object
            int.parse(row['pid']),
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['img'],
            row['category']);
        productitems.add(p); // add the product object to the _products list
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    update(false); // inform through callback that we failed to get data
  }
}

// searches for a single product using product pid
void searchProduct(Function(String text) update, int pid) async {
  try {
    final url = Uri.https(_baseURL, 'searchProduct.php', {'pid':'$pid'});
    final response = await http.get(url)
        .timeout(const Duration(seconds: 30));
    productitems.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Product p = Product(
          int.parse(row['pid']),
          row['name'],
          int.parse(row['quantity']),
          double.parse(row['price']),
          row['img'],
          row['category']
      );
      productitems.add(p);
      update(p.toString());
    }
  }
  catch(e) {
    update("can't load data");
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: productitems.length,
      itemBuilder: (context, index) {
        if (index % 3 == 0) {
          // Start a new row for every three products
          return Row(
            children: [
              SizedBox(width: width * 0.05),
              Expanded(
                child: ProductCard(product: productitems[index]),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: index + 1 < productitems.length
                    ? ProductCard(product: productitems[index + 1])
                    : Container(),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: index + 2 < productitems.length
                    ? ProductCard(product: productitems[index + 2])
                    : Container(),
              ),
              SizedBox(width: width * 0.05),
            ],
          );
        } else {
          // For the middle and last item in the row, we don't need to render anything
          return Container();
        }
      },
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage("assets/img1.jpg"), // Replace with appropriate image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              product._name,
              style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              '\$${product._price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}







