import 'package:flutter/material.dart';
import 'package:smokefree/sign2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ip.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String egender = "Male"; // Default gender
  List<String> genderOptions = ["Male", "Female", "Other"]; // Dropdown options

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();
    final String name = nameController.text.trim();
    final String contact = contactController.text.trim();
    final String email = emailController.text.trim();
    final String age = ageController.text.trim();
    final String gender = egender;
    final String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || name.isEmpty || age.isEmpty || gender.isEmpty || confirmPassword.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fields cannot be empty")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password and Confirm password should be same")));
      return;
    }

    final response = await http.post(
      Uri.parse(ip+'register.php'), // Replace with your API endpoint
      body: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
        'contact': contact,
        'age': age,
        'gender': gender,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        userid=username;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage2()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign Up failed")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${response.statusCode}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E3D3D),
                ),
              ),
              SizedBox(height: 60),
              _buildTextField(nameController, "Name"),
              SizedBox(height: 20),
              _buildTextField(ageController, "Age"),
              SizedBox(height: 20),
              _buildGenderDropdown(),
              SizedBox(height: 20),
              _buildTextField(emailController, "Email"),
              SizedBox(height: 20),
              _buildTextField(contactController, "Contact Number"),
              SizedBox(height: 20),
              _buildTextField(usernameController, "Username"),
              SizedBox(height: 20),
              _buildTextField(passwordController, "Password", obscureText: true),
              SizedBox(height: 20),
              _buildTextField(confirmPasswordController, "Confirm Password", obscureText: true),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Color(0xFF82A8D2),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool obscureText = false}) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E3D3D),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButton<String>(
            value: egender,
            isExpanded: true,
            underline: SizedBox(),
            items: genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                egender = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}
