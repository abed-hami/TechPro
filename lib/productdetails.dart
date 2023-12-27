import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techprostore/products.dart';
import 'package:techprostore/singleProduct.dart';
import 'package:input_quantity/input_quantity.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductD;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
        children: [
          Image.asset(
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
                Text(
                  '\$${product.price.toString()}',
                  style: TextStyle(fontSize: 20, color: Colors.blue.shade500),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputQty(
                maxVal: 3,
                initVal: 0,
                minVal: 1,

                onQtyChanged: (val) {
                  // Handle value changed
                },
               
              ),
            ),
            
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
                SizedBox(height: 10,),
                Text(
                  "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                style: TextStyle(fontWeight: FontWeight.w500,letterSpacing: 1),),
SizedBox(height: 10,),
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
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8), // Adjust the spacing between the icon and text
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
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    // Add your sign-in logic here
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.blue.shade600, // Set the border color here
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
                        SizedBox(width: 8), // Adjust the spacing between the icon and text
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
    );
  }
}
