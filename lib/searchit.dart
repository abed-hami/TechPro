 import 'package:flutter/material.dart';
 import 'adminproducts.dart';


 //
//
// class SearchIt extends StatefulWidget {
//   const SearchIt({Key? key}) : super(key: key);
//
//   @override
//   State<SearchIt> createState() => _SearchState();
// }
//
// class _SearchState extends State<SearchIt> {
//   // controller to store product pid
//   final TextEditingController _controllerID = TextEditingController();
//   String _text = ''; // displays product info or error message
//
//   @override
//   void dispose() {
//     _controllerID.dispose();
//     super.dispose();
//   }
//
//   // update product info or display error message
//   void update(String text) {
//     setState(() {
//       _text = text;
//     });
//   }
//
//   // called when user clicks on the find button
//   void getProduct() {
//     try {
//       String pid = _controllerID.text;
//       searchProduct(update , pid); // search asynchronously for product record
//     }
//     catch(e) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wrong arguments')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Page 1'),
//         centerTitle: true,
//       ),
//       body: Center(child: Column(children: [
//         const SizedBox(height: 10),
//         SizedBox(width: 200, child: TextField(controller: _controllerID,keyboardType: TextInputType.text,
//             decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter ID'))),
//         const SizedBox(height: 10),
//         ElevatedButton(onPressed: getProduct,
//             child: const Text('Find', style: TextStyle(fontSize: 18))),
//         const SizedBox(height: 10),
//         Center(child: SizedBox(width: 200, child: Flexible(child: Text(_text,
//             style: const TextStyle(fontSize: 18))))),
//       ],
//
//       ),
//
//       ),
//     );
//   }
// }
