import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearchVisible = false;
  final List<IconData> icons = [
    Icons.headphones,
    Icons.laptop,
    Icons.phone_android,
    Icons.computer,
    Icons.keyboard_alt_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue.shade700,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tech-Pro",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white, size: 30),
                        onPressed: () {
                          setState(() {
                            isSearchVisible = !isSearchVisible;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: isSearchVisible ? 60 : 0,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search for a product",
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.search, color: Colors.blue.shade600),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: icons.map((icon) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          icon,
                          size: 30,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 2.0,
              ),
              items: [
                buildCarouselItem("https://cdn.zeebiz.com/sites/default/files/styles/zeebiz_850x478/public/2022/12/15/216399-christmas-discounts.jpg?itok=LQW4C3JY"),
                buildCarouselItem("https://www.91-cdn.com/hub/wp-content/uploads/2023/10/image1-2.png"),
                buildCarouselItem("https://pbs.twimg.com/media/DRNkSH6UMAEN-NW.jpg"),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("View More", style: TextStyle(color: Colors.black)),
                  Icon(Icons.arrow_circle_right, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildProductRow(
              "https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/MSFT-surfacelaptopgo2-mobile-hero-RE4Ypdj?scl=1",
              "https://static.skyassets.com/contentstack/assets/blt143e20b03d72047e/blt1c33e1158f1c5ecf/6319d97c454b1c2ebb3f4037/Carousel_iPhone14Plus_Purple_Placement01-PreOrder.png",
            ),
            SizedBox(height: 20),
            buildProductRow(
              "https://files.refurbed.com/pi/asus-zenbook-14-i5-1592206960.jpg",
              "https://zoodmall.com/cdn-cgi/image/w=500,fit=contain,f=auto/https://images2.zoodmall.com/https%3A/www.higalo.com/DynamicImages/ProductsImages/Product-Media-Pic-405-637486349617672328.jpg",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarouselItem(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildProductRow(String imageUrl1, String imageUrl2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildProductContainer(imageUrl1),
          buildProductContainer(imageUrl2),
        ],
      ),
    );
  }

  Widget buildProductContainer(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 150,
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
