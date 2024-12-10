import 'package:flutter/material.dart';
import 'package:smokefree/seduc.dart';
import 'package:smokefree/selfmo.dart';
import 'package:smokefree/soc.dart';
import 'package:smokefree/vm.dart';

import 'ip.dart';
import 'lev.dart';

class DoctorMotive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main Image
            Image.asset(
              'assets/wn.png', // Replace with your asset path
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            // Horizontal Container
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Vertical Column
                Column(
                  children: [
                    // Self Motivation
                    InkWell(
                      onTap: () {
                        t="1";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Vm(), // Replace with your target page
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm1.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Self Motivation',
                              style: TextStyle(
                                fontFamily: 'Amethysta', // Make sure you have this font
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Seduction
                    InkWell(
                      onTap: () {
                        t="3";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Vm(), // Replace with your target page
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm3.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Seduction',
                              style: TextStyle(
                                fontFamily: 'Amethysta', // Make sure you have this font
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                // Second Vertical Column
                Column(
                  children: [
                    // Leverage
                    InkWell(
                      onTap: () {
                        t="2";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Vm(), // Replace with your target page
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm2.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Leverage',
                              style: TextStyle(
                                fontFamily: 'Amethysta', // Make sure you have this font
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Social
                    InkWell(
                      onTap: () {
                        t="4";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Vm(), // Replace with your target page
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm4.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Social',
                              style: TextStyle(
                                fontFamily: 'Amethysta', // Make sure you have this font
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
