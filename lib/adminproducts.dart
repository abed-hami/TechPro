import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:techprostore/searchit.dart';
import 'package:techprostore/updateProduct.dart';

class AdminProduct extends StatelessWidget {
  const AdminProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewList(),
    );
  }
}

const String _baseURL = 'techprostore.000webhostapp.com';

class Product {
  int pid;
  String name;
  String description;
  int quantity;
  double price;
  String img;
  String category;

  Product(
      this.pid,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.img,
      this.category,
      );

  @override
  String toString() {
    return 'PID: $pid Name: $name Quantity: $quantity Price: \$$price Category: $category';
  }
}

List<Product> _products = [];
List<Product> _searchResults = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 8));

    _products.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      for (var row in jsonResponse) {
        Product p = Product(
          int.parse(row['pid']),
          row['name'],
          row['description'],
          int.parse(row['quantity']),
          double.parse(row['price']),
          row['img'],
          row['category'],
        );
        _products.add(p);
      }

      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void deleteProduct(Function(bool success, String message) callback, int pid) async {
  try {
    final url = Uri.https(
      _baseURL,
      'deleteProduct.php',
      {'pid': '$pid'},
    );
    final response = await http.get(url).timeout(const Duration(seconds: 5));
  }catch(e){
    print(e);
  }
}


void searchProduct(Function(Product) update, String name) async {
  try {
    final url = Uri.https(
      _baseURL,
      'searchProduct.php',
      {'Name': '$name'},
    );
    final response = await http.get(url).timeout(const Duration(seconds: 5));

    _searchResults.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      for (var row in jsonResponse) {
        Product p = Product(
          int.parse(row['pid']),
          row['name'],
          row['description'],
          int.parse(row['quantity']),
          double.parse(row['price']),
          row['img'],
          row['category'],
        );
        _searchResults.add(p);
        update(p);
      }
    }
  } catch (e) {
    update(Product(-1, 'Error', 'Error', 0, 0.0, 'Error','Error'));
  }
}

class ShowProducts extends StatelessWidget {
  final List<Product> products;

  const ShowProducts({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    products[index].toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Navigate to the edit screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProduct(products[index].pid),
                              settings: RouteSettings(arguments: products[index] )
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteProduct((bool success, String message) {
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          }
                        }, products[index].pid);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



class ViewList extends StatefulWidget {
  const ViewList({Key? key}) : super(key: key);

  @override
  State<ViewList> createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  bool _load = false;
  bool _isSearching = false;
  List<Product> _originalProducts = [];

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data')),
        );
      }
    });
  }

  void startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void endSearch() {
    setState(() {
      _isSearching = false;
      _products = List.from(_originalProducts);
    });
  }

  @override
  void initState() {
    _originalProducts = List.from(_products);
    updateProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: !_load
                ? null
                : () {
              setState(() {
                _load = false;
                updateProducts(update);
              });
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchIt(
                    startSearch: startSearch,
                    endSearch: endSearch,
                  ),
                ),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('Available Products'),
        centerTitle: true,
      ),
      body: _load
          ? _isSearching
          ? ShowProducts(products: _searchResults)
          : ShowProducts(products: _products)
          : const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SearchIt extends StatefulWidget {
  final VoidCallback startSearch;
  final VoidCallback endSearch;

  const SearchIt({
    Key? key,
    required this.startSearch,
    required this.endSearch,
  }) : super(key: key);

  @override
  State<SearchIt> createState() => _SearchItState();
}

class _SearchItState extends State<SearchIt> {
  final TextEditingController _controller = TextEditingController();
  List<Product> _searchedProducts = [];



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void update(Product product) {
    setState(() {
      _searchedProducts.add(product);
    });
  }

  void clearSearch() {
    setState(() {
      _searchedProducts.clear();
    });
  }

  void getProduct() {
    try {
      String name = _controller.text;
      widget.startSearch();
      searchProduct(update, name);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong arguments')),
      );
      widget.endSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                getProduct();
                FocusScope.of(context).unfocus();
              },
              child: const Text('Search', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            for(Product product in _searchedProducts)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    product.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Navigate to the edit screen

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            deleteProduct((bool success, String message) {
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            }, product.pid);

                            updateProducts(update as Function(bool success));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
