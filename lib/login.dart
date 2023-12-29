import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'admin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  final EncryptedSharedPreferences _encryptedData =
  EncryptedSharedPreferences();

  void update(bool success) {
    if (success) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Admin()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to login as admin')),
      );
    }
  }

  Future<void> checkLogin() async {
    if (_controller.text.toString().trim() == '') {
      update(false);
    } else {
      try {
        await _encryptedData.setString(
          'myKey',
          _controller.text.toString(),
        );
        update(true);
      } catch (e) {
        update(false);
      }
    }
  }

  void checkSavedData() async {
    final myKey = await _encryptedData.getString('myKey');
    if (myKey != null && myKey.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Admin(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login Page")
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:Column(
              children: [
                SizedBox(height: 20,),
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.blue.shade700,
                ),
                SizedBox(height: 50,),
                Text(
                  "Login As Admin!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 18),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
                  onTap: ()  {
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
                        "Login",
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
            )
          ),
        ),
      ),
    );
  }
}
