import 'package:flutter/material.dart';
import 'package:smokefree/admin_page.dart';

class AdminLoginPage extends StatelessWidget {
  // Controllers to get input from text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              // Admin Text
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amethysta',
                ),
              ),
              SizedBox(height: 25),

              // Image View
              Image.asset(
                'assets/aaw.png', // Ensure you add this image in the assets folder
                height: 250,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 40),

              // Username Text Field
              TextField(
                controller: _usernameController, // Link controller to the username field
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Password Text Field
              TextField(
                controller: _passwordController, // Link controller to the password field
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 100),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Check if username and password match "admin" and "123"
                  if (_usernameController.text == 'admin' &&
                      _passwordController.text == '123') {
                    // Navigate to AdminPage if the credentials are correct
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  } else {
                    // Show error message if the credentials are incorrect
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid username or password'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Color(0xFF81A7D1),
                ),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
