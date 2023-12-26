import 'package:flutter/material.dart';

class searchBar extends StatefulWidget {
  const searchBar({Key? key}) : super(key: key);

  @override
  _searchBarState createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text('A good day for shopiing',style:TextStyle(color: Colors.white,fontFamily:'Roboto' )),
                IconButton(
                  icon: Icon(Icons.shopping_cart,color: Colors.white,),
                  onPressed: () {
                    // Handle shopping cart action
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
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
                      prefixIcon: Icon(Icons.search, color: Colors.purple.shade900),
                    ),
                  ),
                ),
              ],
            ),
        SizedBox(height: 20,),
        Container(
          color: Colors.white,
          height: 200,
        ),
            SizedBox(height: 20,),

            Row(
              children: [
                Container(
                  color: Colors.white,
                  height: 100,
                  width: 100,
                ),
                SizedBox(width: 20,),
                Container(
                  color: Colors.white,
                  height: 100,
                  width: 100,
                ),
                SizedBox(width: 20,),

                Container(
                  color: Colors.white,
                  height: 100,
                  width: 100,
                ),
              ],
            )



          ],
        ),
      ),
    );
  }
}
