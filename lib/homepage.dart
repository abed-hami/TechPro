import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
      body: Search(),

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
              icon: Iconsax.heart,
              text: 'WishList',
              onPressed: () {
                // Navigate to another page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WishList()),
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
