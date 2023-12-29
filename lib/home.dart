import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:techprostore/cartProduct.dart';
import 'package:techprostore/showproduct.dart';

import 'cart.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _load = false; // used to show products list or progress bar

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.blue.shade500,
          actions: [

            IconButton(onPressed: !_load ? null : () {
              setState(() {
                _load = false; // show progress bar
                updateProducts(update); // update data asynchronously
              });
            }, icon:  Icon(Iconsax.refresh, size: 20,)),
            IconButton(onPressed: !_load ? null : () {
              setState(() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  CartDisplay()));
                // update data asynchronously
              });
            }, icon:  Icon(Iconsax.bag_2, size: 20,)),
            


        ],
          title:  Text('Available Products', style: TextStyle(color: Colors.white,fontSize: 23),),
          centerTitle: true,
        ),
        // load products or progress bar
        body: _load ? const ShowProducts() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}
