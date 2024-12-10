import 'package:flutter/material.dart';
import 'package:smokefree/secondpage.dart';

class firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Text
            SizedBox(height: 120),
            Text(
              'LETS START OUR JOURNEY!!!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Amethysta', // Custom font added to the pubspec.yaml
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50),

            // Image in the center
            Image.asset(
              'assets/gv.png', // Add your image to the assets folder and pubspec.yaml
              width: 300,
              height: 300,
            ),

            SizedBox(height: 20),

            // Bottom Text
            Text(
              'WE WILL HELP YOU TO QUIT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Amethysta', // Custom font added to pubspec.yaml
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 120),

            // Get Started Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => secondpage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                ),
                backgroundColor: Color(0xFF82A8D2), // Background color from the drawable shape
              ),
              child: Text(
                'Get Started',
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
    );
  }
}
