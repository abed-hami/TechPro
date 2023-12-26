import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:techprostore/homepage.dart';
import 'login.dart';
import 'main.dart';
import 'wishlist.dart';
import 'store.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.gif(
        useImmersiveMode: true,
        gifPath: 'assets/gif.gif',
        gifWidth: 269,
        gifHeight: 474,
        nextScreen: const HomePage(),
        duration: const Duration(milliseconds: 3515),
      ),
    );
  }
}
