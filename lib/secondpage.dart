import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smokefree/doctorlogin.dart';
import 'package:smokefree/patlog.dart';

import 'admnlog.dart';

class secondpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop(); // Closes the app
      return false; // Prevents further back navigation
    },
    child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,  // Background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Text - "Choose Your Profile Type"
            Text(
              'Choose Your Profile Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Amethysta',  // Custom font
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Image
            Image.asset(
              'assets/aa.png',  // Add your image to the assets folder and pubspec.yaml
              width: 400,
              height: 380,
            ),
            SizedBox(height: 30),

            // Doctor Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorLoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),  // Rounded corners
                ),
                backgroundColor: Color(0xFF82A8D2),  // Button background color
              ),
              child: Text(
                'Doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Amethysta',  // Custom font
                ),
              ),
            ),
            SizedBox(height: 25),

            // Patient Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientLoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),  // Rounded corners
                ),
                backgroundColor: Color(0xFF82A8D2),  // Button background color
              ),
              child: Text(
                'Patient',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Amethysta',  // Custom font
                ),
              ),
            ),
            SizedBox(height: 30),

            // Admin Text Link
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginPage()),
                );
              },
              child: Text(
                'Admin?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E88E5),  // Text color for admin link
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
