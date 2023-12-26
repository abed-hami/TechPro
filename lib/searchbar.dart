import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [



                    const Column(
                      children: [
                        Center(
                          child:
                          Row(
                            children: [
                              Text("Tech-Pro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                            ],
                          ),
                        )



                      ],
                    ),


                  IconButton(
                    icon: Icon(Icons.search, color: Colors.blue.shade400, size: 30,),
                    onPressed: () {
                      setState(() {
                        isSearchVisible = !isSearchVisible;
                      });
                    },
                  ),
                ],
              ),

              Visibility(
                visible: isSearchVisible,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(color: Colors.blue.shade500,

                    borderRadius: BorderRadius.circular(20)
                ),
                height: 200,
                  child:Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
                        child: Image.asset(
                          "assets/tech.jpg",
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )

              ),
              SizedBox(height: 20),
                Row(
                children: [
                Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                ),
                height: 100,
                width: 100,
                child: Image.asset(
                "assets/img1.jpg",
                fit: BoxFit.cover,
                ),
                ),
                SizedBox(width: 20),
                Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                ),
                height: 100,
                width: 100,
                child: Image.asset(
                "assets/img1.jpg", // Replace with appropriate image path
                fit: BoxFit.cover,
                ),
                ),
                SizedBox(width: 20),
                Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                ),
                height: 100,
                width: 100,
                child: Image.asset(
                "assets/img1.jpg", // Replace with appropriate image path
                fit: BoxFit.cover,
                ),
                ),
                ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
