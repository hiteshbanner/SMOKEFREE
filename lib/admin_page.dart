import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ip.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _doctorIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  final String url = ip+"add_doc.php"; // Update with your actual URL

  Future<void> addDoctor() async {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': _doctorNameController.text.trim(),
        'id': _doctorIdController.text.trim(),
        'password': _passwordController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _genderController.text.trim(),
        'contact': _contactController.text.trim(),
        'email': _mailController.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added successfully')),
        );
        // Optionally clear the fields or navigate elsewhere
        _clearFields();
      } else {
        // Show failure message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add doctor')),
        );
      }
    } else {
      // Handle server error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.statusCode}')),
      );
    }
  }

  void _clearFields() {
    _doctorNameController.clear();
    _doctorIdController.clear();
    _passwordController.clear();
    _ageController.clear();
    _genderController.clear();
    _contactController.clear();
    _mailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop(); // Closes the app
      return false; // Prevents further back navigation
    },
    child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image at the top
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 30),
                  width: double.infinity,
                  height: 130,
                  child: Image.asset('assets/dvd.png', fit: BoxFit.contain),
                ),
                SizedBox(height: 30),
                // Doctor Name Input
                InputField(controller: _doctorNameController, hintText: "Doctor Name"),
                // Doctor Id Input
                InputField(controller: _doctorIdController, hintText: "Doctor Id"),
                // Password Input
                InputField(controller: _passwordController, hintText: "Password"),
                // Age Input
                InputField(controller: _ageController, hintText: "Age"),
                // Gender Input
                InputField(controller: _genderController, hintText: "Gender"),
                // Contact Input
                InputField(controller: _contactController, hintText: "Contact"),
                // Mail Input
                InputField(controller: _mailController, hintText: "Mail"),
                // Add Button
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: addDoctor,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Color(0xFF81A7D1),
                  ),
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

// Custom Widget for Input Field
class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  InputField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16, color: Color(0xFFA29F9F)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF131313)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: TextStyle(fontSize: 16, color: Colors.black),
        textAlign: TextAlign.start,
      ),
    );
  }
}
