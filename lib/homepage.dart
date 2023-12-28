import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:techprostore/cart.dart';
import 'package:techprostore/products.dart';
import 'login.dart';
import 'wishlist.dart';
import 'store.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'products.dart';
import 'searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body:
          Search(),
          // Other widgets or content here



      )

    ;
  }
}

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return  GNav(
          backgroundColor: Colors.grey.shade200,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.lightBlue.shade500,
          gap:8,

          padding: EdgeInsets.all(16),
          tabs:   [
            GButton(
              icon: Iconsax.home,

              text: 'Home',
              onPressed: () {
                // Navigate to another page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),

            GButton(
              icon: Iconsax.shop,
              text: 'Shop',
              onPressed: () {
                // Navigate to another page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Store()),
                );
              },
            ),
            GButton(
              icon: Iconsax.bag_2,
              text: 'Cart',
              onPressed: () {
                // Navigate to another page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartDisplay()),
                );
              },
            ),
            GButton(
              icon: Iconsax.user,
              text: 'login',
              onPressed: () {
                // Navigate to another page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            )
          ]
      );

  }
}


class DataObject {
  final String title;
  final String description;
  final String imageUrl;

  DataObject({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class Products extends StatelessWidget {
  final List<DataObject> data = [
    DataObject(
      title: 'Item 1',
      description: 'Description for Item 1',
      imageUrl: 'assets/img1.jpg',
    ),
    DataObject(
      title: 'Item 2',
      description: 'Description for Item 2',
      imageUrl: 'assets/img2.jpg',
    ),
    DataObject(
      title: 'Item 3',
      description: 'Description for Item 3',
      imageUrl: 'assets/img3.jpg',
    ),
  ];

  Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Carousel Slider Example'),
        ),
        body: CarouselSlider(
          options: CarouselOptions(
            height: 150.0,
            enlargeCenterPage: false,
            autoPlay: true,
          ),
          items: data.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.7, // Adjust the width
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        item.imageUrl,
                        height: 120.0,
                        fit: BoxFit.cover, // Cover the entire container
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item.description,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}