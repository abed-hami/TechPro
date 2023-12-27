import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techprostore/products.dart';
import 'package:techprostore/singleProduct.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductD;
    return Scaffold(
      body: Text(product.name),
    );
  }
}
