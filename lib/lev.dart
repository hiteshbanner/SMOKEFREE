import 'package:flutter/material.dart';
import 'package:smokefree/viddis.dart';

import 'ip.dart';

class Lev extends StatelessWidget {
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
                opt="4";
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
                      'assets/tm2.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Quitting smoking isn\'t just about giving up a habit; it\'s about gaining a life full of vitality and freedom',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 16,
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
                opt="5";
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
                      'assets/tm2.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Every breath you take without a cigarette is a step closer to unlocking a world of health, happiness, and endless possibilities',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 16,
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
                opt="6";
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
                      'assets/tm2.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Unveiling the Benefits Beyond Smoking',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 16,
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
