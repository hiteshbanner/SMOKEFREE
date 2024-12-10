import 'package:flutter/material.dart';
import 'package:smokefree/viddis.dart';

import 'ip.dart';

class Social extends StatelessWidget {
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
        backgroundColor: Color(0xFF82A8D2),
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
                opt="10";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viddis(), // Replace with your target page
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/tm4.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'During tough times, seek support from your network to stay committed to quitting.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 14,
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
                opt="11";
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
                      'assets/tm4.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Celebrate small victories and share progress with loved ones to stay motivated in quitting smoking.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 14,
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
                opt="12";
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
                      'assets/tm4.png',
                      width: 320,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Community Support for a Smoke-Free Life',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
