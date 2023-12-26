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
      body: Products(),


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
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap:8,

          padding: EdgeInsets.all(16),
          tabs:  const [
            GButton(
              icon: Iconsax.home,

              text: 'Home',

            ),
            GButton(
              icon: Iconsax.heart,
              text: 'WishList',
            ),
            GButton(
              icon: Iconsax.shop,
              text: 'Shop',
            ),
            GButton(
              icon: Iconsax.user,
              text: 'login',

            )
          ]
      );

  }
}
