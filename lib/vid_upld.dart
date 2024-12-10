import 'package:flutter/material.dart';
import 'package:smokefree/dv_m.dart';

import 'dv_c.dart';
import 'dv_dq.dart';
import 'ip.dart';
 // Import the pages

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF81A7D1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                child: Text(
                  '\n', // Add title here if necessary
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Image at the top
            Image.asset(
              'assets/dvd.png', // Replace with your asset path
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            // Buttons
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(context, 'Daily Questionnaires', DoctorDq()),
                  _buildButton(context, 'Cravings', DoctorCravings()),
                  _buildButton(context, 'Motivation', DoctorMotive()),
                ],
              ),
            ),
          ],
        ),
      ),
      // No bottom navigation bar here
    );
  }

  // Helper method to build buttons
  Widget _buildButton(BuildContext context, String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if(text=='Daily Questionnaires'){
            opt="0";
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF81A7D1), // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.0),
          textStyle: TextStyle(
            fontFamily: 'Amethysta',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
