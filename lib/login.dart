
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'admin.dart';
import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController(); // hold user key from TextField
  final EncryptedSharedPreferences _encryptedData =
  EncryptedSharedPreferences(); // used to store the key later

  // this function opens the Add Category page, if we managed to save key successfully
  void update(bool success) {
    if (success) { // open the Add Category page if successful
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Admin()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('failed to set key')));
    }
  }

  checkLogin() async {
    // make sure the key is not empty
    if (_controller.text.toString().trim() == '') {
      update(false);
    } else {
      // attempt to save key. Saving the key and encrypting it takes time.
      // so it is done asynchronously
      _encryptedData
          .setString('myKey', _controller.text.toString())
          .then((bool success) { // then is equivalent to using wait
        if (success) {
          update(true);
        } else {
          update(false);
        }
      });
    }
  }

  // opens the Add Category page, if the key exists. It is called when
  // the application starts
  void checkSavedData() async {
    _encryptedData.getString('myKey').then((String myKey) {
      if (myKey.isNotEmpty) {
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) => const Admin()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // call the below function to check if key exists
    checkSavedData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Icon(Icons.lock, size: 100,color: Colors.blue.shade700,
              ),
              SizedBox(height: 50,),
              Text("Welcome back !",style: TextStyle(color: Colors.grey[700],fontSize: 18),),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false, // disable suggestions for password
                  autocorrect: false, // disable auto correct for password
                  controller: _controller,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Email@example.com",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 10,),

              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  checkLogin();
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
