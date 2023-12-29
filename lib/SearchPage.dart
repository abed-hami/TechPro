import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techprostore/productdetails.dart';
import 'package:techprostore/singleProduct.dart';

import 'adminproducts.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<ProductD> _searchResults = [];

  void _searchProducts(String name) async {
    try {
      final url = Uri.https(
        'techprostore.000webhostapp.com', // Replace with your actual base URL
        'searchProduct.php',
        {'Name': name},
      );
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      setState(() {
        _searchResults.clear();

        if (response.statusCode == 200) {
          final jsonResponse = convert.jsonDecode(response.body);

          for (var row in jsonResponse) {
            ProductD p = ProductD(
              int.parse(row['pid']),
              row['name'],
              row['description'],
              int.parse(row['quantity']),
              double.parse(row['price']),
              row['img'],
              row['category'],
            );
            _searchResults.add(p);
          }
        }
      });
    } catch (e) {
      print('Error: $e');
      // Handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search A Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for products',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchProducts(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchResults.isNotEmpty
                  ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.7, // Adjust the aspect ratio
                ),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.0),
                              ),
                              child: Image.network(
                                _searchResults[index].img,
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
                                  _searchResults[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _searchResults[index].description,
                                  style: TextStyle(fontSize: 12),
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
                            arguments: _searchResults[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
                  : Center(
                child: Text('No results found.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
