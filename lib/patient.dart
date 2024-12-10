import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smokefree/cravings.dart';
import 'package:smokefree/motivation.dart';
import 'package:smokefree/patienthome.dart';
import 'package:smokefree/patprof.dart';

class Patient extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<Patient> {
  int _currentIndex = 0; // Index to keep track of selected bottom navigation item

  final List<Widget> _pages = [
    PatientHomePage(), // Page for home content
    CravingsPage(), // Placeholder for Health page
    Motivation(), // Placeholder for Money page
    PatProfPage() // Placeholder for Profile page
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop(); // Closes the app
      return false; // Prevents further back navigation
    },
    child:  Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: _buildCustomBottomAppBar(), // Use the custom BottomAppBar
    ));
  }

  // Custom BottomAppBar
  Widget _buildCustomBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 1.0,
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFF82A8D2),
            width: 2.0,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.medical_services, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.attach_money, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder Widgets for the other pages
class PatientHomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Patient Home Page Content'));
  }
}

class PatientHealthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Patient Health Page'));
  }
}

class PatientMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Patient Money Page'));
  }
}

class PatientProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Patient Profile Page'));
  }
}
