import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techprostore/cart.dart';
import 'package:techprostore/products.dart';
import 'package:techprostore/singleProduct.dart';
import 'package:input_quantity/input_quantity.dart';

import 'cartProduct.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductD;
    double total = product.returnTotal();
    int q = 1;

    void isExist() {
      if (!cartproducts.contains(
        CartProduct(
            product.pid, product.name, product.price, total, product.img),
      )) {
        cartproducts.add(
          CartProduct(
              product.pid, product.name, product.price, total, product.img),
        );
        _showSnackBar("added to cart");
      } else {
        _showSnackBar("already in cart");
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(product.name, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade500,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the left
            children: [
              Image.network(
                product.img,
                width: 400,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Column(
                      children: [
                        Text(
                          'initial:  \$${product.price.toString()}\n',
                          style: TextStyle(
                              fontSize: 20, color: Colors.green.shade700),
                        ),
                        Text("Total:  \$${product.returnTotal()}",
                            style: TextStyle(
                                fontSize: 20, color: Colors.red.shade500)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:
                  InputQty(

                    maxVal: 3, //max val to go
                    initVal: 1,
                    minVal:1,//min starting val
                    onQtyChanged: (val) {
                      setState(() {
                        q = val as int;
                        product.updateTotal(q);
                      });//on value changed we may set the value

                    },
                  ),
                )
                ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      style: TextStyle(fontSize: 29),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add your sign-in logic here
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(
                                width:
                                    8), // Adjust the spacing between the icon and text
                            Text(
                              "Buy Now!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExist();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors
                                .blue.shade600, // Set the border color here
                            width: 1, // Set the border width if needed
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              color: Colors.blue.shade600,
                              size: 24,
                            ),
                            SizedBox(
                                width:
                                    8), // Adjust the spacing between the icon and text
                            Text(
                              "Add to cart!",
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
    ;
  }
}
