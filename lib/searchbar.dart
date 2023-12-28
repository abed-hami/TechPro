import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 7),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                color: Colors.blue.shade500,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            fontSize: 24,
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
                    SizedBox(height: 10),
                    Visibility(
                      visible: isSearchVisible,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(19.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search for a product",
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.search, color: Colors.blue.shade600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: icons.map((icon) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              icon,
                              size: 30,
                              color: Colors.black,
                            ),
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
                ),
                items: [
                  Image.network("https://cdn.zeebiz.com/sites/default/files/styles/zeebiz_850x478/public/2022/12/15/216399-christmas-discounts.jpg?itok=LQW4C3JY"),
                  Image.network("https://www.91-cdn.com/hub/wp-content/uploads/2023/10/image1-2.png", fit: BoxFit.cover),
                  Image.network("https://pbs.twimg.com/media/DRNkSH6UMAEN-NW.jpg", fit: BoxFit.cover),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("View More", style: TextStyle(color: Colors.black)),
                    Icon(Icons.arrow_circle_right, color: Colors.black),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildProductRow("https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/MSFT-surfacelaptopgo2-mobile-hero-RE4Ypdj?scl=1", "https://static.skyassets.com/contentstack/assets/blt143e20b03d72047e/blt1c33e1158f1c5ecf/6319d97c454b1c2ebb3f4037/Carousel_iPhone14Plus_Purple_Placement01-PreOrder.png"),
              SizedBox(height: 20),
              buildProductRow("https://files.refurbed.com/pi/asus-zenbook-14-i5-1592206960.jpg", "https://zoodmall.com/cdn-cgi/image/w=500,fit=contain,f=auto/https://images2.zoodmall.com/https%3A/www.higalo.com/DynamicImages/ProductsImages/Product-Media-Pic-405-637486349617672328.jpg"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductRow(String imageUrl1, String imageUrl2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildProductContainer(imageUrl1),
        SizedBox(width: 20),
        buildProductContainer(imageUrl2),
      ],
    );
  }

  Widget buildProductContainer(String imageUrl) {
    return Container(
      color: Colors.white,
      height: 150,
      width: 150,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
