import 'package:flutter/material.dart';
import 'package:smokefree/viddis.dart';

import 'ip.dart';

class Seduc extends StatelessWidget {
  void _onContainerTap(int index) {
    // Handle the onTap action based on the container index
    print('Container $index tapped');
    // You can navigate to different pages or show dialogs here based on the index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF82A8D2), // Replace with your appbar color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                opt="7";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viddis(), // Replace with your target page
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/tm3.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Know the risks, stay safe. Smoking hides dangers; awareness keeps you out of harm\'s way',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 15,
                          color: Color(0xFF222121),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                opt="8";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viddis(), // Replace with your target page
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/tm3.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'See through smoke, see through risks. Being aware saves lives; stay informed, stay healthy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 15,
                          color: Color(0xFF222121),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                opt="2";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viddis(), // Replace with your target page
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/tm3.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Navigating the Dangers of Smoking',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 15,
                          color: Color(0xFF222121),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
